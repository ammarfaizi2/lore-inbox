Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRG1TIC>; Sat, 28 Jul 2001 15:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRG1THw>; Sat, 28 Jul 2001 15:07:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266997AbRG1THp>; Sat, 28 Jul 2001 15:07:45 -0400
Subject: Re: binary modules (was Re: ReiserFS / 2.4.6 / Data Corruption)
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Sat, 28 Jul 2001 20:08:46 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        kiwiunixman@yahoo.co.nz (Matthew Gardiner),
        pauld@egenera.com (Philip R. Auld),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Richard Gooch" at Jul 28, 2001 01:44:05 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QZSA-00083U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> The right answer for vendors who want to ship binary modules is to
> ship an Open Source interface layer which shields the vendor from
> kernel drift (since users will be able to build the interface layer if
> they need to, without waiting for the vendor).

As people have seen from vmware and from the ever growing piles of 
nvidia crashes the truth about binary modules in general even with glue is
pain and suffering.

Veritas have some good Linux people though, and while I'm sad they won't
open source the core of veritas they do at least appear to have the
knowledgebase to do a good job
