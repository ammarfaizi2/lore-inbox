Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279987AbRKDNpL>; Sun, 4 Nov 2001 08:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279988AbRKDNpC>; Sun, 4 Nov 2001 08:45:02 -0500
Received: from mail004.mail.bellsouth.net ([205.152.58.24]:7507 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279987AbRKDNoo>; Sun, 4 Nov 2001 08:44:44 -0500
Message-ID: <3BE54643.B0761F5@mandrakesoft.com>
Date: Sun, 04 Nov 2001 08:44:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Sean Middleditch <elanthis@awesomeplay.com>, linux-kernel@vger.kernel.org
Subject: Re: Via Onboard Audio - Round #2
In-Reply-To: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
	 <1004849558.457.15.camel@stargrazer>
	 <3BE4CC20.5FFEC4B5@mandrakesoft.com> <5.1.0.14.2.20011104131312.02bd8ae8@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Linux is not
> a PNP OS and hence problems like yours often get fixed by setting in the
> BIOS that you are not using a PNP OS.

Incorrect.  PCI IRQ routing (net effect of "PNP OS: Yes") works fine for
everybody except those with Sean's type of PCI IRQ routing table.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

