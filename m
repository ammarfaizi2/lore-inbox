Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLANhy>; Fri, 1 Dec 2000 08:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQLANho>; Fri, 1 Dec 2000 08:37:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbQLANhe>; Fri, 1 Dec 2000 08:37:34 -0500
Subject: Re: watchdog software
To: oles@ovh.net (octave klaba)
Date: Fri, 1 Dec 2000 13:06:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A279952.BD684AD9@ovh.net> from "octave klaba" at Dec 01, 2000 01:28:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141pts-0000Dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a problem on a 2.2.17: sometimes it crashs
> without any reason (no high load), there is no kernel panic,
> the screan is black. We setup watchdog software and
> we realized watchdog can not reboot this box whe it crashs
> (on the others servers it works fine).
> 
> my question is:
> what kind of problem can have this serveur:
> hardware or software ?

What sort of watchdog are you using ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
