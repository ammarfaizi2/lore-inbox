Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJANhA>; Mon, 1 Oct 2001 09:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275061AbRJANgk>; Mon, 1 Oct 2001 09:36:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55820 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273565AbRJANgb>; Mon, 1 Oct 2001 09:36:31 -0400
Subject: Re: more goodies from 2.4.9-ac16 on
To: linux4u@wanadoo.es (Pau Aliagas)
Date: Mon, 1 Oct 2001 14:42:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml), alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0110011503170.1299-100000@pau.intranet.ct> from "Pau Aliagas" at Oct 01, 2001 03:06:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15o3Kc-0001KT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry to followup myself... I was too fast :( as the zombies are still
> there. Many processes in Z state ([galeon-bin <defunct>]) til the parent
> dies and only then all die.

That is correct behaviour. It means the parent is buggy
