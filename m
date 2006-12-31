Return-Path: <linux-kernel-owner+w=401wt.eu-S933159AbWLaNDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbWLaNDa (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbWLaNDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:03:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:4725 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933159AbWLaND3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:03:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OuD3nNG/gzjsWN3SJQh77Y11XIWXUdyo8eJcI1tlDXwo3dqeSVuQ2mU59NPJsX8+0zQqqFACuPLkaNhVsGOK5yh1z6TYF2UBsAC/b6ERnHj+acHP4LZkwm5hIZhfsiy96VrlJo3IZ2k0IXak+P8bnWCdf05c6ucB0ioUGMIz5Rc=
Message-ID: <3d57814d0612310503r282404afgd9b06ca57f44ab3c@mail.gmail.com>
Date: Sun, 31 Dec 2006 23:03:27 +1000
From: "Trent Waddington" <trent.waddington@gmail.com>
To: "Bernd Petrovitsch" <bernd@firmix.at>
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
Cc: "Erik Mouw" <erik@harddisk-recovery.com>, Valdis.Kletnieks@vt.edu,
       "Giuseppe Bilotta" <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1167568899.3318.39.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20061215T220806-362@post.gmane.org>
	 <200612162007.32110.marekw1977@yahoo.com.au>
	 <4587097D.5070501@opensound.com>
	 <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
	 <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu>
	 <20061222115921.GT3073@harddisk-recovery.com>
	 <1167568899.3318.39.camel@gimli.at.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, Dec 21, 2006 at 01:16:15PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > > At least nVidia *does* actually Get It, they just don't have a choice in
> > > implementing it, because all their current hardware includes patents that
> > > they licensed from other companies

What makes you think they "get it"?

In a recent interview
(http://bsdtalk.blogspot.com/2006/07/bsdtalk054-interview-with-andy-ritger.html)
the nvidia developer had this to say:

"Quite honestly we have a lot of ip sorrounding both our hardware and
our software. And so the driver we provide is binary only, ya know, to
protect that intellectual property. You know, I guess, on a software
side, so much of what we do, err, of the code that comprises that
drivers is common and leveraged across all the operating systems and I
think that is a big benefit. You know we are able to accomplish a lot
with a fairly small, err, unix specific engineering team because we're
able to leverage so much common code. Ya know, that really is a big
win for us and our users, and so, ya know, we provide a binary only
driver to protect that ip. Umm, that said, we do try to, ya know,
provide source for, err, ya know, for things when it makes sense and
its possible to do so. I guess for our various unix graphics drivers,
the interface between *cough* excuse me, the core of the binary, err
the core of the kernel module is operating system neutral .. is
shipped binary only but anything that, ya know, interacts directly
with, with unix kernel, be it linux or freebsd or whatever, we provide
the source code to that interface layer. Similarly, err, I guess, up
in user space, umm, you know, we were talking either about, umm, the
nvida X extension and our control panel nvidia-settings. The source
code for that is provided as GPL. We provide a command line tool
nvidia-xconfig for manipulating your xconfiguration files. We provide
that as GPL. So we do try to provide source code to those sorts of
utilities and things like that when it makes sense. Umm, but the core
of our driver, we only provide as binary."

Yeah, really sounds like he "gets it".

Why don't you release source?  To protect the intellectual property.
Well, duh!  That's why everyone holds back source.  So allow me to
translate..

Why don't you release source?  Because we don't believe in freedom, we
don't "get it" and we don't want you to have it.

That wasn't some marketting stooge they were interviewing either, it
was two of the guys who work on the unix porting team for the nvidia
drivers.

They don't get it.

Trent
