Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSANTx5>; Mon, 14 Jan 2002 14:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSANTwa>; Mon, 14 Jan 2002 14:52:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25607 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288982AbSANTvy>; Mon, 14 Jan 2002 14:51:54 -0500
Subject: Re: Memory problem with bttv driver
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 20:03:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020114204818.24a253cc.skraw@ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 08:48:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QDKf-0002kT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bttv                   60848   0 

bttv wants a reasonable amount

> NVdriver              720128  14  (autoclean)

Thats my guess. Mapping all the memory on your geofarce will not be a small
amount.

Alan
