Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264531AbRFJOli>; Sun, 10 Jun 2001 10:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264532AbRFJOl2>; Sun, 10 Jun 2001 10:41:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20747 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264531AbRFJOlQ>; Sun, 10 Jun 2001 10:41:16 -0400
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
To: stelian.pop@fr.alcove.com
Date: Sun, 10 Jun 2001 15:39:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010610152526.B13172@ontario.alcove-fr> from "Stelian Pop" at Jun 10, 2001 03:25:26 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1596NC-0006g5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver does not yet support overlay (no docs... :-( ), but it does =
> support

Are you sure the hardware supports overlay ?

> grabbing, jpeg snapshots and mjpeg compressed videos (through a private=
>  API,
> documented in <file:Documentation/video4linux/meye.txt>).

We have an API for mjpeg in the buz, I wonder if its possible to make that
more generic.

