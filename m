Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280777AbRKBSmg>; Fri, 2 Nov 2001 13:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280778AbRKBSm2>; Fri, 2 Nov 2001 13:42:28 -0500
Received: from [208.232.58.25] ([208.232.58.25]:3795 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280777AbRKBSmV>;
	Fri, 2 Nov 2001 13:42:21 -0500
Subject: Re: APM/ACPI
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zjGe-0003Du-00@the-village.bc.nu>
In-Reply-To: <E15zjGe-0003Du-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 13:41:52 -0500
Message-Id: <1004726512.4921.41.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so there's a good chance then that if I compile in ACPI I can have
things work OK.  Do I need something besides apmd to handle all that? 
Will stuff like the GNOME battery applet still work?

Sean Etc.

On Fri, 2001-11-02 at 13:42, Alan Cox wrote:
> > I dunno, perhaps there is some proprietary protocol?  Is ACPI backwards
> > compat with APM?  I mean, if the laptop doesn't support APM, would that
> > mean it can't support ACPI?
> 
> ACPI and APM are exclusive but a BIOS can contain both. Its up to the OS
> not to try and run both together.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


