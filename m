Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136541AbRD3W7N>; Mon, 30 Apr 2001 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136542AbRD3W6y>; Mon, 30 Apr 2001 18:58:54 -0400
Received: from mnh-1-05.mv.com ([207.22.10.37]:32518 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S136541AbRD3W6e>;
	Mon, 30 Apr 2001 18:58:34 -0400
Message-Id: <200105010011.TAA04345@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Paul J Albrecht <pjalbrecht@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Mon, 30 Apr 2001 16:17:22 EST."
             <01043016264000.00697@CB57534-A> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Apr 2001 19:11:35 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pjalbrecht@home.com said:
> Where can I find an analysis of the relative strengths and weaknesses
> of KDB and KGDB for kernel debug? Has the linux community come to any
> consensus regarding the utility one or the other? 

You ought to add UML to the list, since it is useful for debugging any part of 
the kernel that's not arch code or a hardware device driver (except that 
there's now USB support for UML).

				Jeff


