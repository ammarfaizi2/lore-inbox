Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135655AbREIVcj>; Wed, 9 May 2001 17:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135660AbREIVcX>; Wed, 9 May 2001 17:32:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135655AbREIVbS>; Wed, 9 May 2001 17:31:18 -0400
Subject: Re: MCradiolists: line 2: syntax error near unexpected token
To: juhl@eisenstein.dk (Jesper Juhl)
Date: Wed, 9 May 2001 22:35:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF9D0B9.2010406@eisenstein.dk> from "Jesper Juhl" at May 10, 2001 01:20:25 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xbcH-0003LC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just unpacked a fresh copy of 2.4.4 and patched it to 2.4.5pre1 and 
> ran into a problem. When I attempt to change the type (through 
> menuconfig) of CPU to compile for, the following gets dumped to the 
> console:

Grab the menuconfig diff from the -ac patches . Menuconfig had a bug in 
bracket handling the new config file tripped

