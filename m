Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265694AbSJSWu6>; Sat, 19 Oct 2002 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265695AbSJSWu6>; Sat, 19 Oct 2002 18:50:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5644 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265694AbSJSWu6>; Sat, 19 Oct 2002 18:50:58 -0400
Date: Sat, 19 Oct 2002 15:54:46 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
cc: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
In-Reply-To: <3DB1DF34.3000600@quark.didntduck.org>
Message-ID: <Pine.LNX.4.10.10210191550060.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Brian Gerst wrote:

> Andre Hedrick wrote:
> > So could you ask the question a little more blunt?
> > 
> > "Gee, I am trying to break a US Law on content protection, would you be my
> > enabler?  Don't worry, it only effects the US, and we are in a public
> > forum.  Also, do you prefer gray or black in your future pin stripped
> > suit?"
> 
> Attempting to read a "defective" disc should never, ever, cause a kernel 
> oops.  Whether it succeeds or not is irrelevant.

Please point out where in the original post, the referrence to "defective"
media.  If this would have been the case, your point it valid.  If I
missed something, thus am wrong, I will admit to being wrong.

Warning (compare_maps): ksyms_base symbol
__io_virt_debug_R__ver___io_virt_debug not found in System.map.
  Ignoring ksyms_base entry
Unable to handle Kernel Null pointer dereference at virtual address 00000018
f08968f8

First how can the trace be meaningful if ksymoops detects a miscompare on
the system map?

Cheers,

Andre Hedrick
LAD Storage Consulting Group



