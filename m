Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311433AbSDIUfE>; Tue, 9 Apr 2002 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311445AbSDIUfD>; Tue, 9 Apr 2002 16:35:03 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12939 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S311433AbSDIUfD>;
	Tue, 9 Apr 2002 16:35:03 -0400
Date: Mon, 8 Apr 2002 01:38:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3
Message-ID: <20020408013801.B329@toy.ucw.cz>
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com> <20020408214612.GR961@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Linux 2.4.19pre5-ac3
> > o	Software suspend initial patch 		(Pavel Machek, Gabor Kuti,..)
> > 	| Don't enable this idly. Its here to get exposure and so
> > 	| people can bring the rest of the code up to meet its needs as
> > 	| well as fix it.
> > 	| Read the docs first!
> 
> Didn't enable software suspend, but I do use ACPI...

Looks like we need some #ifdefs in acpi... I'll fix that.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

