Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbUL0Pq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUL0Pq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUL0Pq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:46:56 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:8367 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261912AbUL0Pqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:46:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hbBtOUt6Ok5dfFUkUiJ9Mjbd6fzdJBjW3T2OL2yODspmfuW5B6LZAWRbqmxZVDYs58Y+3zgtvz/Cg1HF5s1Q4DbYDg6B4kvxjaxkTARLygssBCII8xYg0gw5eM4cxY0/dLKgi2Q51DIEONa/B28fhabiptk3oLmPi1dCZLZNf/4=
Message-ID: <58cb370e04122707465d775090@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:46:53 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac1
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104157732.20952.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104103881.16545.2.camel@localhost.localdomain>
	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>
	 <58cb370e041226174019e75e23@mail.gmail.com>
	 <1104157732.20952.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 14:28:53 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2004-12-27 at 01:40, Bartlomiej Zolnierkiewicz wrote:
> > > Do you want to force people to disable the io-apic just because of
> > > option removal? In my case the serialized devices are a disk and a
> > > dvd-rw which is rarely used, so disabling the io-apic is a bad solution.
> >
> > No, I want them to fix the problem - whenever it is - ide or apic code. :)
> 
> Or hardware, or SMM ....
> 
> There are some very complex obscure platform specific funnies that end
> up solved by serialize that I doubt anyone will get to the bottom of
> before all the worlds parallel ATA drives have turned to rust (and/or
> sand).
> 
> It seems the gnome desktop disease[1] is spreading to some kernel
> people. It's all init code, its cheap and it works. Making it automated
> in more cases is great, but you'll never stamp out the need for the
> manual one even if its to do the debug to get the automated case right.
> 
> Alan
> 
> [1] Removing configuration features people need before (if ever)
> providing a working alternative that is automatic.

I use KDE. 8)

Sigh, nothing got removed yet...
