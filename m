Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRIAMcz>; Sat, 1 Sep 2001 08:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRIAMcp>; Sat, 1 Sep 2001 08:32:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54032 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270495AbRIAMcg>; Sat, 1 Sep 2001 08:32:36 -0400
Subject: Re: Adaptec ASR2100s support?
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Sat, 1 Sep 2001 13:35:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0109011422400.7322-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Sep 01, 2001 02:23:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dA0C-0004uH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does any of you know if there's support for the Adaptec ASR2100s
> controller? It seems to be an old DPT chipset, although I don't know the
> exact values of anything.

DPT wrote drivers and after some cycles of them cleaning them up they are in
the 2.4.9-ac kernel and targetted for Linus tree.

Alan
