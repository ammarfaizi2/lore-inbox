Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286986AbSABMVA>; Wed, 2 Jan 2002 07:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286980AbSABMUk>; Wed, 2 Jan 2002 07:20:40 -0500
Received: from mta43-acc.tin.it ([212.216.176.239]:16002 "EHLO
	fep43-svc.tin.it") by vger.kernel.org with ESMTP id <S286979AbSABMUj>;
	Wed, 2 Jan 2002 07:20:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Flavio Stanchina <flavio.stanchina@tin.it>
Organization: not at all
To: andre@linux-ide.org
Subject: ide.2.4.16.12102001.patch: please provide help for new config options
Date: Wed, 2 Jan 2002 13:20:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020102122032.MFVM3377.fep43-svc.tin.it@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,
I downloaded the ide.2.4.16.12102001.patch from linuxdiskcert.org and I 
applied it to 2.4.17. Compiles fine, but now I'm looking for documentation 
and there doesn't seem to be any on linuxdiskcert.org. Could you provide 
us with basic help text for the following new configuration options?

CONFIG_IDEDISK_STROKE
CONFIG_IDE_TASK_IOCTL
CONFIG_IDE_TASKFILE_IO
CONFIG_BLK_DEV_IDEDMA_FORCED
CONFIG_IDEDMA_ONLYDISK

Which ones are we supposed to enable for better performance, reliability, 
etc. and which ones are for compatibility? I would guess 
CONFIG_IDEDMA_ONLYDISK pertains to the latter category for example.

Please CC me, I'm not on linux-kernel.

-- 
Ciao,
    Flavio Stanchina
    Trento - Italy

"The best defense against logic is ignorance."
http://spazioweb.inwind.it/fstanchina/
