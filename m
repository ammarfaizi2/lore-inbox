Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbTLFNb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbTLFNb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:31:27 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:58002
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265163AbTLFNb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:31:26 -0500
Date: Sat, 6 Dec 2003 08:40:32 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Message-ID: <20031206084032.A3438@animx.eu.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3FD1994C.10607@stinkfoot.org>; from Ethan Weinstein on Sat, Dec 06, 2003 at 03:54:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noted this at boot several times with 2.6.0-test11
> 
> Dec  4 23:59:21 e-d0uble kernel: ide-scsi is deprecated for cd burning! 
> Use ide-cd and give dev=/dev/hdX as device

At the moment, I don't have a burner on a 2.6.0 machine, however, why is
ide-scsi depreciated?  On every PC I have that has an ide cd drive, I use
ide-scsi.  I like the fact that scd0 is the cdrom drive.  Instead of
guessing if it's hdb hdc or hdd (in the case of this laptop, the dvd was hdb
and the modular cdrw was hdc).

On a side note, has anyone had any luck with Acard's SCSIDE AEC-7722 adapter
on dvd burners?  I was planning on this adapter on an optorite dd0401 dvd
burner.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
