Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSKCNXU>; Sun, 3 Nov 2002 08:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKCNXU>; Sun, 3 Nov 2002 08:23:20 -0500
Received: from main.gmane.org ([80.91.224.249]:44756 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261867AbSKCNXT>;
	Sun, 3 Nov 2002 08:23:19 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: PROBLEM: fbdev & irq sharing
Date: Sun, 03 Nov 2002 08:30:54 -0500
Message-ID: <aq389q$d70$1@main.gmane.org>
References: <Pine.LNX.4.44L.0211030919220.10247-101000@darkstar.wszechswiat.gov>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036330106 13536 130.127.121.177 (3 Nov 2002 13:28:26 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Sun, 3 Nov 2002 13:28:26 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Poplawski wrote:

> 
> Last question follows: Is Nvidia planning to
> relase drivers for kernel v2.5??
> 

Never.  They don't support development kernels, so the next kernel they will 
support aside from 2.4 will be 2.6.  I suggest you do as I have done: write 
nVidia asking them to release their drivers under the GPL and get them 
integrated into the kernel tree.  If that doesn't suit you, you can always 
try to use previous patches and fix up the driver to work in 2.5.

Cheers,
Nicholas



