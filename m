Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRCFCEj>; Mon, 5 Mar 2001 21:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130842AbRCFCE3>; Mon, 5 Mar 2001 21:04:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7431 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130834AbRCFCET>; Mon, 5 Mar 2001 21:04:19 -0500
Subject: Re: Linux 2.4.2ac12
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 6 Mar 2001 02:06:46 +0000 (GMT)
Cc: jamagallon@able.es (J . A . Magallon),
        ksi@cyberbills.com (Sergey Kubushin),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0103051809180.27373-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 05, 2001 06:11:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a6sE-0008GS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yuck. Build-dependency on libdb-dev is not pretty. What is it used for,
> anyway? Assembler in need of libdb. Mind boggleth...

Could it perhaps be persuaded to use Tridge's tdb, which at < 1000 lines could
simply be included with it...
