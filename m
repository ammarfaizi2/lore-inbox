Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSDQQ1Y>; Wed, 17 Apr 2002 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSDQQ1X>; Wed, 17 Apr 2002 12:27:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17682 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293203AbSDQQ1W>; Wed, 17 Apr 2002 12:27:22 -0400
Subject: Re: IDE/raid performance
To: nick@snowman.net
Date: Wed, 17 Apr 2002 16:48:20 +0100 (BST)
Cc: bbn-linux-kernel@clansoft.dk (Baldur Norddahl),
        mdresser_l@windsormachine.com (Mike Dresser),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204171108480.3300-100000@ns> from "nick@snowman.net" at Apr 17, 2002 11:15:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xrfQ-0002VF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 432watts.  This will go down alot after all your disks spin up, but I'm
> amazed your system boots.  Morale of this message:  Don't be a dipshit and
> put 12 IDE disks on a single power supply.

I've run a dual athlon set up fully loaded with cards with 10 disks - that
takes a 550W PSU but works
