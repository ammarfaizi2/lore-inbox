Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSANR3C>; Mon, 14 Jan 2002 12:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287786AbSANR2x>; Mon, 14 Jan 2002 12:28:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20485 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287793AbSANR23>; Mon, 14 Jan 2002 12:28:29 -0500
Subject: Re: Memory problem with bttv driver
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 17:40:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20020114181210.67650995.skraw@ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 06:12:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QB5s-0002J9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yesterday we came across another MM related problem. This time its related to
> the bttv-driver. We do very simple things:

Do you trust your kernel build ? The bt848 drivers are working beautifully
for me in 2.4.18pre
