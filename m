Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVEXAhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVEXAhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEXAhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:37:55 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:24994 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261247AbVEXAho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:37:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: dvyas@cs.uh.edu
Subject: Re: kernel 2.6.11.10, smp nice patch results ??
Date: Tue, 24 May 2005 10:39:43 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <33567.129.7.248.115.1116889489.squirrel@129.7.248.115>
In-Reply-To: <33567.129.7.248.115.1116889489.squirrel@129.7.248.115>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505241039.44216.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005 09:04 am, Deepti Vyas wrote:
> I tried using 2.6.11.10 with patch-2.6.11-smpnice-1.diff.

It partially worked but some bugs were present and it has been resynced with 
the latest -mm kernel. Can you try 
http://ck.kolivas.org/patches/smpnice/patch-2.6.12-rc4-mm2-smpnice-1.diff
on top of
linux-2.6.12-rc4-mm2

Cheers,
Con

P.S. please don't email me 3 different ways and separate the mailing list 
email from the personal ones and so on. One copy cc'ed to relevant places is 
enough :|
