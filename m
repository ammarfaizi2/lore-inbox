Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311467AbSCNDFt>; Wed, 13 Mar 2002 22:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311489AbSCNDFh>; Wed, 13 Mar 2002 22:05:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311467AbSCNDF1>; Wed, 13 Mar 2002 22:05:27 -0500
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
To: jt@hpl.hp.com
Date: Thu, 14 Mar 2002 03:20:47 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> from "Jean Tourrilhes" at Mar 13, 2002 06:59:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lLnM-0008E8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the new Wireless Extension API to 2.4.X so that they can hack their
> drivers without having to deal with 2.5.X. This patch just do that, so
> could you please add that to your tree ?

Would it be better to leave the patch where said driver people can get it,
and when they submit drivers needing it (if ever) then merge it ?
