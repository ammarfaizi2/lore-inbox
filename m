Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135829AbRDYHqb>; Wed, 25 Apr 2001 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135831AbRDYHqV>; Wed, 25 Apr 2001 03:46:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23057 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135829AbRDYHqI>; Wed, 25 Apr 2001 03:46:08 -0400
Subject: Re: [PATCH] Single user linux
To: daniel@kabuki.openfridge.net (Daniel Stone)
Date: Wed, 25 Apr 2001 08:45:25 +0100 (BST)
Cc: aaronl@vitelus.com (Aaron Lehmann), imel96@trustix.co.id,
        daniel@kabuki.openfridge.net (Daniel Stone),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <20010425103246.C11099@piro.kabuki.openfridge.net> from "Daniel Stone" at Apr 25, 2001 10:32:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14sJzL-0003x6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> True, but then imagine trying to hack C (no, that's a CURLY BRACE, and a
> tab! not space! you just broke my makefiles! aargh!), and compiling
> Netfilter (it takes HOW MANY hours to compile init/main.c?!?) on a PDA.

Usual misguided assumptions

1.	Many PDA's have a keyboard
2.	The ipaq has an optional fold up keyboard
3.	Modern PDA's have 200Mhz processors and XScale will see some of them
	hitting 600MHz+

