Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRKSLI6>; Mon, 19 Nov 2001 06:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKSLIt>; Mon, 19 Nov 2001 06:08:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277798AbRKSLIk>; Mon, 19 Nov 2001 06:08:40 -0500
Subject: Re: IPV4 socket layer,  was: nfs problem: aix-server --- linux 2.4.15pre5 client
To: b.lammering@science-computing.de (Birger Lammering)
Date: Mon, 19 Nov 2001 11:16:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15352.56551.709659.146271@stderr.science-computing.de> from "Birger Lammering" at Nov 19, 2001 11:20:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165mPr-0006F5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 13:47:28.337776317 truncated-ip - 18 bytes missing!capc25.muc.796 > caes04.muc.shilp: P 2059179904:2059180060(156) ack 4022052897 win 17520 (DF)

Right so someone is truncating frames. I'd start with the hub then work
outwards. 
