Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSGJLSt>; Wed, 10 Jul 2002 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSGJLSs>; Wed, 10 Jul 2002 07:18:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14091 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315593AbSGJLSr>; Wed, 10 Jul 2002 07:18:47 -0400
Subject: Re: Oops with kernel BUG at dcache.c:345
To: a.d.opmeer@student.utwente.nl (Arjan Opmeer)
Date: Wed, 10 Jul 2002 12:38:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020710054916.GA1800@Ado.student.utwente.nl> from "Arjan Opmeer" at Jul 10, 2002 07:49:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SFnV-0006to-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My Linux machine just crashed during the morning cronjob with an Oops. Yes,
> I know my kernel is tainted because I have the NVidia driver loaded, but
> consider that maybe this driver is not the direct cause of the Oops but only
> exposing an obscure bug in the kernel?

You'll have to ask Nvidia about that. Only they have enough source code
to tell

Please don't send tainted and nvidia reports to the kernel list
