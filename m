Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269568AbRHHVmZ>; Wed, 8 Aug 2001 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269569AbRHHVmO>; Wed, 8 Aug 2001 17:42:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269568AbRHHVl5>; Wed, 8 Aug 2001 17:41:57 -0400
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: rhw@MemAlpha.CX (Riley Williams)
Date: Wed, 8 Aug 2001 22:42:47 +0100 (BST)
Cc: ankry@pg.gda.pl (Andrzej Krzysztofowicz), mra@pobox.com (Mark Atwood),
        soruk@eridani.co.uk (Michael McConnell),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108082211410.12565-100000@infradead.org> from "Riley Williams" at Aug 08, 2001 10:31:02 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ub6F-00068c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One point to remind people of here. You can runtime rename interfaces.
Almost all the needed kernel infrastructure is there already.

Alan
