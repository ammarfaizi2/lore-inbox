Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRKXXdU>; Sat, 24 Nov 2001 18:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKXXdK>; Sat, 24 Nov 2001 18:33:10 -0500
Received: from mnh-1-12.mv.com ([207.22.10.44]:14596 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S280494AbRKXXcz>;
	Sat, 24 Nov 2001 18:32:55 -0500
Message-Id: <200111250050.TAA06745@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
Cc: Adam Feuer <adamf@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: [swsusp] Re: swsusp for 2.4.14 
In-Reply-To: Your message of "Fri, 23 Nov 2001 13:46:40 GMT."
             <20011123134639.A55@toy.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Nov 2001 19:50:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
>  Yep, its doable, but way harder than other ports where you only have
> to restore CPU registers. And yes it would be cool. 

Yeah, Linux has a lot more "processor state" than the typical physical CPU.

And I agree it would be very cool.

				Jeff

