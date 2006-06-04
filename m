Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750704AbWFDQGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFDQGN (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWFDQGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:06:13 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:11487 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1750704AbWFDQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:06:12 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "davor emard" <davoremard@gmail.com>
Subject: Re: SMP HT + USB2.0 crash
Date: Sun, 4 Jun 2006 17:06:28 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
In-Reply-To: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041706.28073.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 11:22, davor emard wrote:
> Usually SMP + EHCI crashes like this

Please attach another log without NVIDIA ever having being loaded. This is a 
technical forum, we need precise facts "nvidia has not been loaded", not 
vague recollections "nvidia probably wasn't loaded some time before".

Secondly, I highly recommend running memtest86 on your system for at least a 
couple of passes. You can download an ISO from the homepage and boot it from 
a CD. If this fails, you have faulty memory.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
