Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263316AbRFEUjz>; Tue, 5 Jun 2001 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263332AbRFEUjp>; Tue, 5 Jun 2001 16:39:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6918 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263316AbRFEUjb>; Tue, 5 Jun 2001 16:39:31 -0400
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
To: remi@a2zis.com (Remi Turk)
Date: Tue, 5 Jun 2001 21:37:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010605184438.A1390@localhost.localdomain> from "Remi Turk" at Jun 05, 2001 06:44:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157NaL-0007MD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.5-ac[4678] all lock hard (no sysreq) when pushing my
> power-button (setup from the bios to go to standby) or
> when running apm --standby. (apm version 3.0final, RH6.2)
> apm --suspend works the way it should.
> 
> 2.4.5/2.4.6-pre1 don't hardlock.

Are you using the same build options for both
What machine is this - laptop ?

