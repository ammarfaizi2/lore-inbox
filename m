Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312127AbSCQWHU>; Sun, 17 Mar 2002 17:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312128AbSCQWHK>; Sun, 17 Mar 2002 17:07:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28678 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312127AbSCQWGx>; Sun, 17 Mar 2002 17:06:53 -0500
Subject: Re: 2.4.19-pre3-ac1 - Quotactl patch
To: spstarr@sh0n.net (Shawn Starr)
Date: Sun, 17 Mar 2002 22:22:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0203171555100.18389-100000@coredump.sh0n.net> from "Shawn Starr" at Mar 17, 2002 03:55:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mj2l-0003Up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might want to upgrade to the newer one, the patch has undergone a lot
> of changes and -ac against the XFS merge of the quotactl patch seriously
> breaks ;-(

The -ac patch is the current stable 2.4 one for 32bit uid quota. XFS is 
a 2.5 problem so for the moment I'm not remotely bothered by it

