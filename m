Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267622AbTBKLd7>; Tue, 11 Feb 2003 06:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbTBKLd7>; Tue, 11 Feb 2003 06:33:59 -0500
Received: from kim.it.uu.se ([130.238.12.178]:63363 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S267622AbTBKLd5>;
	Tue, 11 Feb 2003 06:33:57 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15944.57838.89789.240408@kim.it.uu.se>
Date: Tue, 11 Feb 2003 12:43:42 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <20030210161031.GA443@elf.ucw.cz>
References: <200302091407.PAA14076@kim.it.uu.se>
	<20030210161031.GA443@elf.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > cpu_has_apic test seems wrong: AFAICS, there are CPUs that have apic
 > but linux does not know how to use it.

Please give a reference. I don't know of any x86-type CPU that
fits your description above.

/Mikael
