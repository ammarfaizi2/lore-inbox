Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280130AbRKECqX>; Sun, 4 Nov 2001 21:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKECqN>; Sun, 4 Nov 2001 21:46:13 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:32524 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S280130AbRKECqE>; Sun, 4 Nov 2001 21:46:04 -0500
Subject: Re: APM/ACPI
From: Sean Middleditch <elanthis@awesomeplay.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15zjOs-0003FH-00@the-village.bc.nu>
In-Reply-To: <E15zjOs-0003FH-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 04 Nov 2001 21:49:58 -0500
Message-Id: <1004928598.1969.1.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erg, hrm.  In 2.4.13 (Debian version, Linux tree I think) I enabled
ACPI, disabled APM.  The latop locks up when the base ACPI support is
loaded.

How should I go about debugging this?  I want this working.

Thanks,
Sean Etc.

On Fri, 2001-11-02 at 13:50, Alan Cox wrote:
> > OK, so there's a good chance then that if I compile in ACPI I can have
> > things work OK.  Do I need something besides apmd to handle all that? 
> > Will stuff like the GNOME battery applet still work?
> 
> If you compile in ACPI your box might work. You will need different 
> (development) tools and suspend wont work yet. ACPI is getting to the 
> useful point but not quite there - expect an adventure
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


