Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWALB2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWALB2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWALB2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:28:00 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17832 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964949AbWALB17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:27:59 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs II - more problems
Date: Thu, 12 Jan 2006 02:25:46 +0100
User-Agent: KMail/1.8.2
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       mingo@elte.hu
References: <200601112126.59796.ak@suse.de> <200601120155.26679.ak@suse.de> <20060111171402.3f79e9f9.akpm@osdl.org>
In-Reply-To: <20060111171402.3f79e9f9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120225.47142.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 02:14, Andrew Morton wrote:

> Are you using MD?
> 
> sata?   If so, which?

None of both. old style IDE using VIA driver.

-Andi
