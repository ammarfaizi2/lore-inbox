Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293702AbSCABPs>; Thu, 28 Feb 2002 20:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCABMX>; Thu, 28 Feb 2002 20:12:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64016 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310293AbSCABKR>; Thu, 28 Feb 2002 20:10:17 -0500
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
To: texas@ludd.luth.se (texas)
Date: Fri, 1 Mar 2002 01:25:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSU.4.33.0202280355460.24329-100000@father.ludd.luth.se> from "texas" at Feb 28, 2002 04:07:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbnM-0001x7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> are present as well as "init.c:148: bad pte 3fff3163" but none seem

The bad pte one needs looking into. That may actually be  cured in the
bt_ioremap diffs pending though.

Alan
