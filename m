Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUGNVFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUGNVFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUGNVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:05:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:9671 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264638AbUGNVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:05:31 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@fs.tum.de>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.8-rc1-mm1
Date: Wed, 14 Jul 2004 23:08:01 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040713182559.7534e46d.akpm@osdl.org>
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407142308.01408.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 July 2004 03:25, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6
>.8-rc1-mm1/

next one:

  CC [M]  drivers/scsi/sg.o
drivers/scsi/sg.c: In function `sg_ioctl':
drivers/scsi/sg.c:209: nicht implementiert: >>inline<< beim Aufruf von 
>>sg_jif_to_ms<< gescheitert: function body not available
drivers/scsi/sg.c:930: nicht implementiert: von hier aufgerufen
make[3]: *** [drivers/scsi/sg.o] Fehler 1
make[2]: *** [drivers/scsi] Fehler 2
make[1]: *** [drivers] Fehler 2

greets
dominik
