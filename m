Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbQJaDeI>; Mon, 30 Oct 2000 22:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130091AbQJaDd6>; Mon, 30 Oct 2000 22:33:58 -0500
Received: from harzserver1.harz.de ([193.159.181.124]:50449 "EHLO
	harzserver1.harz.de") by vger.kernel.org with ESMTP
	id <S130085AbQJaDdp>; Mon, 30 Oct 2000 22:33:45 -0500
Date: Mon, 30 Oct 2000 21:48:20 +0100
From: Gerhard Fuellgrabe <gerd@cacofonix.harz.de>
To: linux-kernel@vger.kernel.org
Subject: Q: ip_masq module for battlecom?
Message-ID: <20001030214820.A13204@cacofonix.fuenet.harz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

in my LAN there are users working on battle.net (Starcraft,
Diablo2 etc.). There is a Linux 2.2.14 box routing the LAN
with private IP addresses to the internet (with IP masqerading).

A feature that does not work is the battlecom communication. 
Is there an ip_masq module available for this (like e.g. 
ipv4/ip_masq_cuseeme.o or ipv4/ip_masq_quake.o) or is anybody
working on this?

Regards,
Gerry

-- 
Gerhard Füllgrabe             Phone: +49.5323.96788   Fax: 962044
Arnikaweg 34                              Mobile: +49.170.3508588
D-38678 Clausthal-Zellerfeld                 E-mail: gerd@harz.de

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
