Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJUOLq>; Sun, 21 Oct 2001 10:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRJUOLg>; Sun, 21 Oct 2001 10:11:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276094AbRJUOLZ>; Sun, 21 Oct 2001 10:11:25 -0400
Subject: Re: AIC7XXX-EISA hang at boot
To: i@stingr.net (Paul P Komkoff Jr)
Date: Sun, 21 Oct 2001 15:17:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011021160312.D39722@stingr.net> from "Paul P Komkoff Jr" at Oct 21, 2001 04:03:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vJQA-0006SS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so - do anybody know what's wrong with aic7xxx and who broke it after
> 2.4.7ac5 so it can't work on hardware described here ?

For EISA use aic7xxx_old or get the latest version from Justin Gibbs site
