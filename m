Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWE3Bj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWE3Bj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWE3Bj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:39:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:52402 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932106AbWE3Bj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:39:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1VY7Sk0E7EBOtysHKw46DwuHhm6PsFzbPtWDmTkaxMU7zDiMgtaytecafbIP7maYLCgGI2gacD1DZv2ujcTH1urXHj+zWV5Rl2Xu9k/BCzdQlA0orIwuAsb3XH8U9ZNg6gJUqAUlAzCGdv2awqYUIxRYW6+CEVEMdTcbHSeF+M=
Message-ID: <441e43c90605291839jff1c34bqe6ea176ee6f3e0ce@mail.gmail.com>
Date: Mon, 29 May 2006 20:39:53 -0500
From: "Ian Kester-Haney" <ikesterhaney@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <4423333a0605291648w11a66440xcd9f833f654fb468@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <4423333a0605291648w11a66440xcd9f833f654fb468@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, from the flames you'd expect something to emerge.
>From an end-user standpoint, you are all raving lunatics.

Regressions, the graphics subsystem is a regression,
   back to the days of dos and basic video cad functionality.
   linux kernel development has switched to a very rapid pace of development
           internal ABIs and APIs are in a constant state of flux and
you argue that no
                 regressions are allowed
   you support the newest processor and chipset technology and yet
graphics are text
          and X windows only?
I don't suggest that vgacon and fbdev should be dropped, merely that a better
alternative may be introduces into the -mm kernel.   Using hacks and under
 appreciated drm and forcing the Corporate Vendors to work between
 X and the console is a retarded way of doing things.

So let me offer a suggestion,
     Add an experimental 'accelfb' system to accompany the basic vgacon
     Start with the proper code and plug away, us lunatics can test it
     Merge new functionality while removing old crud.
     Accelfb should not be forced onto old hardware that can't support it
     Neither can the kernel rely on third parties to do all the heavy lifting
           xorg and the distro maintainers

Backwards Compatibility
     As far as I can tell, the kernel user-land interface has been
rapidly changing
     Why shouldn't new power be added to the linux kernel
     Do all features and drivers in the linux kernel fully maintain
backwards compat.

Linux will never take the desktop or even come close if you excuses
for developers
     run the show.  Looks like you guys are starting to resemble
Microsoft, DOS had
     the same problems you are having now with regard to graphics and you
     are repeating the same mistakes that made windows and the mac os more
     dominant than *nix in the corporate and retail world.

Grow up and get real, give hardware manufacurers real solid and stable
interfaces
so that they don't have to be in lock-step with the kernel.

Thanks,
     Ian

FLAMES WELCOME
