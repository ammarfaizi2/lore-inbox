Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSGXXJV>; Wed, 24 Jul 2002 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGXXJV>; Wed, 24 Jul 2002 19:09:21 -0400
Received: from pcp748332pcs.manass01.va.comcast.net ([68.49.120.123]:2539 "EHLO
	pcp748332pcs.manass01.va.comcast.net") by vger.kernel.org with ESMTP
	id <S317642AbSGXXJV>; Wed, 24 Jul 2002 19:09:21 -0400
Date: Wed, 24 Jul 2002 19:12:27 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resolve ACPI oops on boot
Message-ID: <20020724231227.GA11168@bittwiddlers.com>
References: <20020718231509.A539@brodo.de> <Pine.LNX.3.96.1020723165428.2194A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020723165428.2194A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.58
Reply-To: Matthew Harrell 
	  <mharrell-dated-1027984349.032751@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You give neither the kernel version nor the architecture, so I can't be
> sure what's happening or what the compiler might do. I don't find that
> code in the kernel I have on this machine (2.4.19-pre7-jam6) but that
> diesn't mean much. The routine in hardware/hwregs.c on my kernel would
> seem to pass the width correctly, but clearly this is a very different
> version.

Actually, I found this patch accidently since it didn't list the kernel
version but it exactly fixed my ACPI oops I was getting on boots of the
2.5.2[6-7] kernels.  I posted the relevent oops about a week ago under the
subject "2.5.2[6-7] ACPI oops" but I can send it to you if you're interested

-- 
  Matthew Harrell                          Any sufficiently advanced technology
  Bit Twiddlers, Inc.                       is indistinguishable from a rigged
  mharrell@bittwiddlers.com                 demo.
