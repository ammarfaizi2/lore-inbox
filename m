Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285150AbRLXQbG>; Mon, 24 Dec 2001 11:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLXQaq>; Mon, 24 Dec 2001 11:30:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285150AbRLXQak>; Mon, 24 Dec 2001 11:30:40 -0500
Subject: Re: Reaiser fs
To: theuteck@yahoo.com (bil Jeschke)
Date: Mon, 24 Dec 2001 16:41:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011224040036.52568.qmail@web20106.mail.yahoo.com> from "bil Jeschke" at Dec 23, 2001 08:00:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IY9u-0004TV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ooops, i figured out what went wrong, but if I have to
> enable the experimental drivers, of which Reiser is
> not, then why is ext3 a choice when it is labeled
> experimental and I did not enable the experimental drivers?

It would mean that not all the experimental checks are right. Take a look
at fs/Config.in and you can probably see how to fix it and then send
Marcelo a patch
