Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRCAMf3>; Thu, 1 Mar 2001 07:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRCAMfT>; Thu, 1 Mar 2001 07:35:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129456AbRCAMfH>; Thu, 1 Mar 2001 07:35:07 -0500
Subject: Re: [linux-usb-devel] USB oops Linux 2.4.2ac6
To: david-b@pacbell.net (David Brownell)
Date: Thu, 1 Mar 2001 12:38:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <113501c0a1fa$1499e5e0$6800000a@brownell.org> from "David Brownell" at Feb 28, 2001 06:48:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YSLX-0007mZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> makes it handle lowspeed devices wrong ... AMD told me I'd need
> an NDA to learn their workaround, and I've not pursued it.  (Does
> anyone already know what kind of NDA they use?)

It varies depending on the info. They may well be able to sort out a sane
NDA with you. If they dont want to then I guess it would be best if the
ohci driver printing a message explaining the component has an undocumented
errata fix, gave AMD's phone number and refused to load..

