Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbRG1QYD>; Sat, 28 Jul 2001 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbRG1QXx>; Sat, 28 Jul 2001 12:23:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266914AbRG1QXs>; Sat, 28 Jul 2001 12:23:48 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Date: Sat, 28 Jul 2001 17:25:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pauld@egenera.com (Philip R. Auld),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <01072902183404.02683@kiwiunixman.nodomain.nowhere> from "Matthew Gardiner" at Jul 29, 2001 02:18:34 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QWto-0007r1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> I've noticed that in the menuconfig there is support for the Vertias 
> Journalling File System. Has there been any push for that to be a "bootable" 
> filesystem so it can be used for Linux?

The Linux freevxfs module is read only currently. Veritas apparently will be
releasing the genuine article for Linux but binary only with all the mess
that entails
