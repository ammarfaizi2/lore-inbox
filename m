Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUGNU07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUGNU07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUGNU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:26:59 -0400
Received: from imap.gmx.net ([213.165.64.20]:63446 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263117AbUGNU0v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:26:51 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8-rc1-mm1
Date: Wed, 14 Jul 2004 22:29:18 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040713182559.7534e46d.akpm@osdl.org>
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407142229.20241.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 July 2004 03:25, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6
>.8-rc1-mm1/

  CC [M]  drivers/net/8139too.o
drivers/net/8139too.c: In function `rtl8139_open':
drivers/net/8139too.c:616: nicht implementiert: >>inline<< beim Aufruf von 
>>rtl8139_start_thread<< gescheitert: function body not available
drivers/net/8139too.c:1362: nicht implementiert: von hier aufgerufen
make[3]: *** [drivers/net/8139too.o] Fehler 1
make[2]: *** [drivers/net] Fehler 2
make[1]: *** [drivers] Fehler 2
make[1]: Verlasse Verzeichnis »/usr/src/linux-2.6.6«
make: *** [stamp-build] Fehler 2

gcc 3.4

greets
dominik
