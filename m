Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261199AbRELOaH>; Sat, 12 May 2001 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261252AbRELO36>; Sat, 12 May 2001 10:29:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261199AbRELO3s>; Sat, 12 May 2001 10:29:48 -0400
Subject: Re: 2.4.4 kernel freeze for unknown reason
To: mikeg@wen-online.de (Mike Galbraith)
Date: Sat, 12 May 2001 15:25:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linuxkernel@AdvancedResearch.org (Vincent Stemen),
        jq419@my-deja.com (Jacky Liu), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105121504560.365-100000@mikeg.weiden.de> from "Mike Galbraith" at May 12, 2001 03:45:17 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yaLB-0004CF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does any swap write/release if you hit such a box with heavy duty IO?
> (pages on dirty list, swapspace allocated but writeout defered?)

Hard to tell. I switched my desktop box back to 2.2 a while back
until the VM works. 

Alan

