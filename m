Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287809AbSAAKgH>; Tue, 1 Jan 2002 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287807AbSAAKfw>; Tue, 1 Jan 2002 05:35:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12563 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287800AbSAAKfP>; Tue, 1 Jan 2002 05:35:15 -0500
Subject: Re: Why would a valid DVD show zero files on Linux?
To: bryce@obviously.com (Bryce Nesbitt)
Date: Tue, 1 Jan 2002 10:46:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        Lionel.Bouton@free.fr (Lionel Bouton), Andries.Brouwer@cwi.nl
In-Reply-To: <3C307464.2253E26@obviously.com> from "Bryce Nesbitt" at Dec 31, 2001 09:21:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMQj-0008Hv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Understood.   However, why can't that combination "just work"?  Changing
> /etc/fstab every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
> Certainly that "other operating system" does not make me do that.

man fstab
man ln

Its not a hard problem to solve that one
