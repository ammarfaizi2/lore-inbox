Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276572AbRI2SYj>; Sat, 29 Sep 2001 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276573AbRI2SY3>; Sat, 29 Sep 2001 14:24:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276572AbRI2SYW>; Sat, 29 Sep 2001 14:24:22 -0400
Subject: Re: PROBLEM: AST P/75 causes Machine Check Exception type 0x9 on v2.4.10
To: daniel.elvin@fagotten.org (Daniel Elvin)
Date: Sat, 29 Sep 2001 19:29:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BB5F4C6.DDB15B49@fagotten.org> from "Daniel Elvin" at Sep 29, 2001 06:20:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nOrR-0002d1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Booting an AST Bravo P/75 with kernel v2.4.10 results in a "CPU#0
> Machine Check Exception: 0x10C938 (type: 0x9)".

Please try 2.4.9ac17 - it should be fixed in the -ac tree, and if so I can
push it on to Linus

Alan
