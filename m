Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUBRPrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUBRPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:47:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:25498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267597AbUBRPrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:47:37 -0500
Date: Wed, 18 Feb 2004 07:47:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <16435.14044.182718.134404@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
 <16435.14044.182718.134404@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Mikael Pettersson wrote:
> 
> What about naming? IA-64 is taken, AMD64 is too specific, Intel's
> "IA-32e" sounds too vague, and I find x86-64 / x86_64 difficult to type.
> "x64" perhaps?

x86-64 it is. Maybe you can remap one of your function keys to send the 
sequence ;)

This whole "ia32" crap has always been ridiculous - nobody has _ever_ 
called an x86 anything but x86, and Intel is just making it worse by 
adding random illogical letters to the end.

In contrast, x86-64 tells you _exactly_ what it's all about, and is what 
the kernel has always called the architecture anyway.

		Linus
