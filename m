Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281157AbRKLWiy>; Mon, 12 Nov 2001 17:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281189AbRKLWit>; Mon, 12 Nov 2001 17:38:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52754 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281157AbRKLWh4>; Mon, 12 Nov 2001 17:37:56 -0500
Subject: Re: File System Performance
To: Lionel.Bouton@free.fr (Lionel Bouton)
Date: Mon, 12 Nov 2001 22:45:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF04E1A.2070205@free.fr> from "Lionel Bouton" at Nov 12, 2001 11:32:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163Ppf-0007Pd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> An ugly hack in tar justified by a lack of functionnality in Amanda ?!
> Would be typical behavior in a closed-source environnement and make me 
> ROTFL :-/

Amanda uses tar to size archives. Its actually a tweak to tar that probably
should have been tar --size-only instead
