Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135257AbRDVTkp>; Sun, 22 Apr 2001 15:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135265AbRDVTkg>; Sun, 22 Apr 2001 15:40:36 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:58037 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S135257AbRDVTkW>;
	Sun, 22 Apr 2001 15:40:22 -0400
Message-Id: <m14rPhz-000OdiC@amadeus.home.nl>
Date: Sun, 22 Apr 2001 20:39:47 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: rui.sousa@mindspeed.com
Subject: Re: ide-cs module name mismatch.
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0104222117540.1417-100000@localhost.localdomain>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0104222117540.1417-100000@localhost.localdomain> you wrote:

> The kernel module is called ide-cs while the pcmcia-cs package
> looks for ide_cs. I'm not sure which should be corrected...
 
pcmcia-cs I'd say.
