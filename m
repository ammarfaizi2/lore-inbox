Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSBMM5x>; Wed, 13 Feb 2002 07:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291619AbSBMM5i>; Wed, 13 Feb 2002 07:57:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291621AbSBMM5P>; Wed, 13 Feb 2002 07:57:15 -0500
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 13 Feb 2002 13:10:38 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3C6A606C.1060604@evision-ventures.com> from "Martin Dalecki" at Feb 13, 2002 01:47:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16azBG-0005DM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But please just show me a non x86 architecture which is using the 
> i810_audio driver! 

To start with the i810 audio code is the same code as is used for the AMD768
southbridge which can be used with an Alpha processor + AMD762
