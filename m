Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbRFKQSz>; Mon, 11 Jun 2001 12:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbRFKQSp>; Mon, 11 Jun 2001 12:18:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261685AbRFKQSZ>; Mon, 11 Jun 2001 12:18:25 -0400
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
To: hps@intermeta.de
Date: Mon, 11 Jun 2001 17:17:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9g20fn$on4$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at Jun 11, 2001 08:45:43 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159UNC-0008P4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this a "binary only" driver or just a driver on par with the NVidia
> that is just "GPL'ed but unreadable"?

There are reasons the GPL carefully defines it

"The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable."
