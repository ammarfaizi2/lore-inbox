Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJ0Phi>; Sat, 27 Oct 2001 11:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJ0Ph2>; Sat, 27 Oct 2001 11:37:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27908 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274544AbRJ0PhO>; Sat, 27 Oct 2001 11:37:14 -0400
Subject: Re: [PATCH] 2.4.13-ac2: Appletalk Config Screwed
To: rml@tech9.net (Robert Love)
Date: Sat, 27 Oct 2001 16:44:15 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1004164050.3272.7.camel@phantasy> from "Robert Love" at Oct 27, 2001 02:27:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xVd9-0003bg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Appletalk configure file is butchered, resulting in various
> problems: `make oldconfig' always prompts on CONFIG_ATALK, `make
> [*]config' returns "ERROR - Attempting to write value for unconfigured
> variable (CONFIG_ATALK).", etc etc.

I can't duplicate the problem described
