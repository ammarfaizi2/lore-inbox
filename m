Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129268AbRCENWf>; Mon, 5 Mar 2001 08:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRCENWZ>; Mon, 5 Mar 2001 08:22:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18450 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129268AbRCENWS>; Mon, 5 Mar 2001 08:22:18 -0500
Subject: Re: kmalloc() alignment
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 5 Mar 2001 13:24:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kenn@linux.ie (Kenn Humborg),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <200103050940.KAA21120@cave.bitwizard.nl> from "Rogier Wolff" at Mar 05, 2001 10:40:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZuyF-00071y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I know, you can count on 16-bytes alignment from
> kmalloc. The trouble is that you would have to keep the original

Actually it depends on the debug settings


