Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264103AbRFSJnM>; Tue, 19 Jun 2001 05:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264108AbRFSJnC>; Tue, 19 Jun 2001 05:43:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264103AbRFSJmu>; Tue, 19 Jun 2001 05:42:50 -0400
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" and "gameport_unregister_port" in char/joystick/[cs461x.o, emu10k1
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 19 Jun 2001 10:41:21 +0100 (BST)
Cc: miles@megapathdsl.net (Miles Lane), linux-kernel@vger.kernel.org
In-Reply-To: <18479.992943115@kao2.melbourne.sgi.com> from "Keith Owens" at Jun 19, 2001 07:31:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CI0f-0005h1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .config.  If they are different then it was a menuconfig order
> problem[*], if they are the same then I need your full .config, not
> just an extract.
> 
> [*] A good reason to use CML2 ;)

You don't need CML2 to resolve dependancy orders and clashes, CML1 is 
expressing the constraints, its just a tool issue
