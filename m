Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRJOLvt>; Mon, 15 Oct 2001 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJOLvk>; Mon, 15 Oct 2001 07:51:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274813AbRJOLvb>; Mon, 15 Oct 2001 07:51:31 -0400
Subject: Re: 2.4.13-pre1: sonypi.c compile error
To: svgeloven@zonnet.nl (Sander van Geloven)
Date: Mon, 15 Oct 2001 12:58:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, vgeloven@zonnet.nl
In-Reply-To: <3BCB0A02.9DF231A@zonnet.nl> from "Sander van Geloven" at Oct 15, 2001 12:08:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15t6Ne-0001uI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I also have the same problem as Eyal Lebedinskynew:

i2o is broken in Linus tree right now. I've not had time to isolate and
test the right patches yet but I'll send the bits on to Linus fairly soon
