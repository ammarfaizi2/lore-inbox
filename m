Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278114AbRJWRgN>; Tue, 23 Oct 2001 13:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278119AbRJWRgE>; Tue, 23 Oct 2001 13:36:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278114AbRJWRfu>; Tue, 23 Oct 2001 13:35:50 -0400
Subject: Re: SiS630S FrameBuffer & LCD
To: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Tue, 23 Oct 2001 18:42:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011023153015.F4709@khazad-dum> from "Henrique de Moraes Holschuh" at Oct 23, 2001 03:30:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w5Yw-0000Q5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed. We need fully updated docs from SiS on how to deal with their newest
> "contribution" to the onboard-video family.

SiS actually had a much updated frame buffer console driver that never made
it into the kernel (stuff needed fixing and I never got a reply so it
dropped out of the tree)

It may be worthing finding out if SiS have the relevant stuff around
