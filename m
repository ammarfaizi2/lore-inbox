Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTI2PFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTI2PFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:05:37 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:55248 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S263502AbTI2PFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:05:32 -0400
Date: Mon, 29 Sep 2003 17:05:29 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "Leonard Milcin Jr." <thervoy@post.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't X be elemenated?
Message-ID: <20030929150529.GP11543@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <LAW11-F18b4SaFMwr9y00007564@hotmail.com> <3F784706.2000607@post.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F784706.2000607@post.pl>
X-Operating-System: vega Linux 2.6.0-test5 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 04:51:50PM +0200, Leonard Milcin Jr. wrote:
> >Can't X be elemenated?
> >
> >I mean to say kernel level support for graphics device drivers and special
> >routines for accessing it directly; rest will be done by user space widget
> >libraries (or say a kernel space light widget library which can be 
> >customized
> >by user space libraries).
> 
> Yeah. I have read some time ago here "Why not insmod kde?".

:) Funny ;-) So we want another windows where communication on quite deep
level of the system is associated with windows and hells like this to
discover basic security design problems? :) No. kernel is about the core
of the system, 'window' and likes are user space stuffs, kernel is NOTHING
to do with windows and likes. However it would be nice, if XFree used
framebuffer of the kernel beause eg switching between X and console terminals
are not always dead-lock free and other problems can arise as well ...

- Gábor (larta'H)
