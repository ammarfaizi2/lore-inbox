Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRINJMw>; Fri, 14 Sep 2001 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271987AbRINJMk>; Fri, 14 Sep 2001 05:12:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271989AbRINJM2>; Fri, 14 Sep 2001 05:12:28 -0400
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Fri, 14 Sep 2001 10:12:50 +0100 (BST)
Cc: trini@kernel.crashing.org (Tom Rini), val@nmt.edu (Val Henson),
        jgarzik@mandrakesoft.com, becker@scyld.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010913220118.A647@one-eyed-alien.net> from "Matthew Dharm" at Sep 13, 2001 10:01:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hp1m-0008Kp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, people will pick up the card, think "gigabit ethernet", and then look
> under the 1000 section.  I don't think anyone will really think GigE and
> then look under 10/100.

List it once under GigE
