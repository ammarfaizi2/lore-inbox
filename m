Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbQJ1KIr>; Sat, 28 Oct 2000 06:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129817AbQJ1KIh>; Sat, 28 Oct 2000 06:08:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2314 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129288AbQJ1KI0>; Sat, 28 Oct 2000 06:08:26 -0400
Subject: Re: [PATCH] Make agpsupport work with modversions
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 28 Oct 2000 11:07:17 +0100 (BST)
Cc: alan@redhat.com (Alan Cox), dwmw2@infradead.org (David Woodhouse),
        vojtech@suse.cz (Vojtech Pavlik),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <7155.972726918@ocs3.ocs-net> from "Keith Owens" at Oct 28, 2000 08:55:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pStS-0005FF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus wants get_module_symbol removed.
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg08791.html

Looks to me like Linus asks if some stuff can go away. I don't see a Linus
comment on the rest of the discussion about why removing it is bad at all.

And by Linus own rules. Its too late for 2.4 unless you can make Ted agree
its a critical fix

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
