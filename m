Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBGTWx>; Wed, 7 Feb 2001 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGTWn>; Wed, 7 Feb 2001 14:22:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129500AbRBGTWf>; Wed, 7 Feb 2001 14:22:35 -0500
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 7 Feb 2001 19:22:19 +0000 (GMT)
Cc: jakub@redhat.com (Jakub Jelinek), greg@linuxpower.cx (Gregory Maxwell),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010207131439.A28015@vger.timpanogas.org> from "Jeff V. Merkey" at Feb 07, 2001 01:14:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QaAX-00016d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In file included from init.c:30:
> ../../prolog.h:344:8: invalid #ident

It doesnt say #ident isnt supported it says your use of it is invalid. What
precisely does that line read ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
