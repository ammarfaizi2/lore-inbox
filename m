Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQLGRii>; Thu, 7 Dec 2000 12:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbQLGRi2>; Thu, 7 Dec 2000 12:38:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:268 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130667AbQLGRiT>; Thu, 7 Dec 2000 12:38:19 -0500
Subject: Re: [whitevampire@MINDLESS.COM: Naptha - New DoS]
To: rodrigob@conectiva.com.br ("Rodrigo Barbosa (aka morcego)")
Date: Thu, 7 Dec 2000 17:10:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <20001207150247.G24723@conectiva.com.br> from "Rodrigo Barbosa (aka morcego)" at Dec 07, 2000 03:02:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1444Yb-0002hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unaffected operating systems:
> * OpenBSD seems to be unaffected
> * Windows 2000 seems to be unaffected

Someone isnt trying hard enough ;)

Linux 2.4 is designed to handle some of these issues, but you need to 
address aspects of this in applications, protocols and elsewhere. Its basically
no different to the synbomb except the resource usage is trickier to control

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
