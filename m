Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSAMXdx>; Sun, 13 Jan 2002 18:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288298AbSAMXdo>; Sun, 13 Jan 2002 18:33:44 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:35868 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S288297AbSAMXd2>; Sun, 13 Jan 2002 18:33:28 -0500
Message-ID: <03ce01c19c87$cfcf4570$0801a8c0@Stev.org>
Reply-To: "James Stevenson" <mistral@stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Tony Glader" <Tony.Glader@blueberrysolutions.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201122347270.16871-100000@blueberrysolutions.com>
Subject: Re: F00F-bug workaround working?
Date: Sun, 13 Jan 2002 23:11:25 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Tony Glader" <Tony.Glader@blueberrysolutions.com>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 12, 2002 9:49 PM
Subject: F00F-bug workaround working?


>
> I have had problems with 2.4.17 running in a Classic Pentium (lot of
> oopses). I'm sure that there's no problem with hardware. Is F00F'bug
> workaround work still?

Hi

it seems to work fine here 2.4.14-2.4.17 anyway.

Dmesg:

Intel Pentium with F0 0F bug - workaround enabled.

/proc/cpuinfo:

f00f_bug : yes

the foof bug would cause the system to hang. not to panic.

out of intrest does anyone know what the hlt bug on the cyrix does ?

thanks
    James




