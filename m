Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272998AbRIIRqX>; Sun, 9 Sep 2001 13:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273005AbRIIRqN>; Sun, 9 Sep 2001 13:46:13 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:27922
	"EHLO awak") by vger.kernel.org with ESMTP id <S272998AbRIIRp4>;
	Sun, 9 Sep 2001 13:45:56 -0400
Subject: Re: COW fs (Re: Editing-in-place of a large file)
From: Xavier Bestel <xavier.bestel@free.fr>
To: John Ripley <jripley@riohome.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <3B9B9917.DA1CC12F@riohome.com>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
	<318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua>
	<3B9B80E2.C9D5B947@riohome.com>  <3B9B9917.DA1CC12F@riohome.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.07.02.46 (Preview Release)
Date: 09 Sep 2001 19:41:31 +0200
Message-Id: <1000057292.1867.1.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le dim 09-09-2001 at 18:30 John Ripley a _rit :

> /dev/sda6 - /tmp	-  210845 blocks,  17697 duplicates,  8.39%
> /dev/sda7 - /var	-   32122 blocks,   5327 duplicates, 16.58%
> /dev/sdb5 - /home	-  220885 blocks,  24541 duplicates, 11.11%
> /dev/sdc7 - /usr	- 1084379 blocks, 122370 duplicates, 11.28%

How many of these blocks actually belong to file data ?

	Xav

