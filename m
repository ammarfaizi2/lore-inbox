Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272263AbTG1Bix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272254AbTG1ABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272931AbTG0XBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:34 -0400
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
From: Laurens <masterpe@xs4all.nl>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <3F23FD97.60207@genebrew.com>
References: <200307262309.20074.adq_dvb@lidskialf.net>
	 <200307271301.41660.adq_dvb@lidskialf.net> <3F23DB4E.1000203@genebrew.com>
	 <200307271514.00724.adq_dvb@lidskialf.net> <3F23E538.6010900@genebrew.com>
	 <1059320761.13190.9.camel@dhcp22.swansea.linux.org.uk>
	 <3F23FD97.60207@genebrew.com>
Content-Type: text/plain
Message-Id: <1059335516.8706.3.camel@lawbox.int.mpe.xs4all.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 21:51:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read somewhere that this NIC is supposed to be based on the realtek
fast ethernet NIC (rtl8139), could that be worth looking into?

I did modprobe that driver when I first tested 2.6, it loaded without
errors but nothing happened.

Laurens

