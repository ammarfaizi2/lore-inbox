Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276445AbRJHWTP>; Mon, 8 Oct 2001 18:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277200AbRJHWTG>; Mon, 8 Oct 2001 18:19:06 -0400
Received: from AMontpellier-201-1-3-234.abo.wanadoo.fr ([193.252.1.234]:63752
	"EHLO awak") by vger.kernel.org with ESMTP id <S276445AbRJHWS4> convert rfc822-to-8bit;
	Mon, 8 Oct 2001 18:18:56 -0400
Subject: Re: Problem with ACPI on Abit KT7,HPT370
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dominik Geisel <dominik@geisel.info>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011008201040.A1893@geisel.info>
In-Reply-To: <20011008201040.A1893@geisel.info>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.05.19 (Preview Release)
Date: 09 Oct 2001 00:13:51 +0200
Message-Id: <1002579231.6874.21.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le lun 08-10-2001 at 20:10 Dominik Geisel a écrit :

> When ACPI is enabled, it locks up after it detected "hdc: SONY CD-RW",
> the HDD access LED stays on and the system hangs until I do a hard reboot.

ABit VP6, HPT370, same problem here (lock before "hde...")

... plus: locks system on some IDE CDROM read errors, with or without
ACPI.

	Xav

