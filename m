Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130855AbRCFCML>; Mon, 5 Mar 2001 21:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130863AbRCFCMB>; Mon, 5 Mar 2001 21:12:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130855AbRCFCL5>; Mon, 5 Mar 2001 21:11:57 -0500
Subject: Re: kmalloc() alignment
To: kenn@linux.ie (Kenn Humborg)
Date: Tue, 6 Mar 2001 02:14:14 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20010306002912.A14827@excalibur.research.wombat.ie> from "Kenn Humborg" at Mar 06, 2001 12:29:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6zQ-0008Gz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It might be worth asking the question if larger blocks are more
> > aligned?
> 
> OK, I'll bite...
> Are larger blocks more aligned?

Only get_free_page()

Alan

