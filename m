Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSBRTEU>; Mon, 18 Feb 2002 14:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSBRTCy>; Mon, 18 Feb 2002 14:02:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62214 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291099AbSBRSuh>; Mon, 18 Feb 2002 13:50:37 -0500
Subject: Re: Linux 2.4.18-pre9-mjc2
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 18 Feb 2002 19:04:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020217134529.A36@toy.ucw.cz> from "Pavel Machek" at Feb 17, 2002 01:45:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ct5j-0006O3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Be very careful merging lm_sensors. Incorrect use of it is a wonderful
> > way to do things like totally destroy (back to factory) an ibm thinkpad.
> > Thats why I've always stayed clear of it
> 
> They deserve it! Shipping hardware that commits suicide on i2c access is 
> bad thing (tm).

IBM don't replace machines where you do that. So I suspect you'll have a few
users with very different views on the matter.
