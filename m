Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRH3Msx>; Thu, 30 Aug 2001 08:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272198AbRH3Msn>; Thu, 30 Aug 2001 08:48:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272197AbRH3Msc>; Thu, 30 Aug 2001 08:48:32 -0400
Subject: Re: Having problems with 2.4.9-ac
To: ptb@it.uc3m.es
Date: Thu, 30 Aug 2001 13:51:30 +0100 (BST)
Cc: ledzep37@home.com (Jordan), jordan.breeding@inet.com (Jordan Breeding),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200108301216.OAA03980@nbd.it.uc3m.es> from "Peter T. Breuer" at Aug 30, 2001 02:16:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cRIA-00011O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone have the patch diff from 8-ac10 to 8-ac11 in the apm area?
> This sounds very hopeful for tracking down the problem .. if it's not
> just timing.

Basically there are no changes in that are - there is a pnpbios change but
it should be unrelated
