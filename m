Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbVISVHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbVISVHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVISVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:07:22 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:41586 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932691AbVISVHU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:07:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lH0hU54fCg345xT6LF1quHF+R0Av+0O0djXUsUe/jpV6rebnXKkZiw2HEBxt0GE2zdGVtX5edOpxuOPfx9qb3DTwADofoEMKziJbUDbknzW//QX6aLbUQpIblMk6kAPdHZ20aAiwvdKqhulE7RxiqndoNeCKcRi2xJSYfowCPng=
Message-ID: <4746469c05091914071b3927f@mail.gmail.com>
Date: Mon, 19 Sep 2005 14:07:19 -0700
From: Mike Mohr <akihana@gmail.com>
Reply-To: akihana@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: Reboot & ACPI suspend Laptop display initialization
In-Reply-To: <20050919121622.GA2317@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4746469c0509161157bc762bc@mail.gmail.com>
	 <20050916201457.GA29516@ellpspace.math.ualberta.ca>
	 <4746469c05091622163e81dbea@mail.gmail.com>
	 <20050919121622.GA2317@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  It seems unlikely to me that Toshiba will bother fixing a bug
like this (even as serious as this one is) for a 3-yr-old laptop on my
request.  I checked, and I already have the latest BIOS released by
them on 9-24-2002.  The fact that they let a bug as serious as this
through their QA really shocks me, esp. since my wife works for
Panasonic QA and I know the procedures they go through.  I will never
buy from Toshiba again.

Thanks for the responses guys!

Mike

On 9/19/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > This isn't just a problem with ACPI's suspend.  If I reboot the
> > machine, without without power management, the screen isn't properly
> > reinitialized.  The problem with the suspend is certainly an issue
> > with ACPI; however, the reboot issue probably isn't.  Unless someone
> > can enlighten me?
> 
> Well, the reboot issue is broken BIOS... It should reset the hardware
> when you are rebooting.
> 
> Read Doc*/power/video.txt for suspend issues.
>                                                                 Pavel
> --
> if you have sharp zaurus hardware you don't need... you know my address
>
