Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSJ0OnJ>; Sun, 27 Oct 2002 09:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSJ0OnJ>; Sun, 27 Oct 2002 09:43:09 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:58095 "EHLO
	shunka.yo.cz") by vger.kernel.org with ESMTP id <S262414AbSJ0OnJ>;
	Sun, 27 Oct 2002 09:43:09 -0500
Message-ID: <000801c27dc8$044f43f0$4500a8c0@cybernet.cz>
From: "=?iso-8859-2?B?VmxhZGlt7XIgVPhlYmlja/0=?=" <guru@cimice.yo.cz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alex Riesen" <fork0@users.sf.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <clock@atrey.karlin.mff.cuni.cz>
References: <002501c27da9$2524d0f0$4500a8c0@cybernet.cz> <20021027125021.GA1578@riesen-pc.gr05.synopsys.com> <1035724348.30403.15.camel@irongate.swansea.linux.org.uk>
Subject: Re: Swap doesn't work
Date: Sun, 27 Oct 2002 15:48:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's not a badblock. That's an kernel IDE bug. Andre Hedrick and Alan
> > Cox will love to see this.
>
> Not on a kernel built with an untrusted hand built tool chain
>
Well, I don't know what could possibly cause this kind of error except
kernel.
No matter what application I use to read or write /dev/hda6. Which part
of my tool chain do you have in mind?

Thanks,

Vladimir Trebicky

--
Vladimir Trebicky
guru@cimice.yo.cz

