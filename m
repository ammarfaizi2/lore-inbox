Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbTDKJLr (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264013AbTDKJLr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:11:47 -0400
Received: from 213-4-21-244.uc.nombres.ttd.es ([213.4.21.244]:55540 "EHLO
	mail.flconstruccion.com") by vger.kernel.org with ESMTP
	id S263960AbTDKJLo (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:11:44 -0400
Message-ID: <3E96A5E0.8010305@inicia.es>
Date: Fri, 11 Apr 2003 13:24:16 +0200
From: =?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030212 Debian/1.2.1-9woody1
X-Accept-Language: es-es
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Unresolved symbol with SMP compiled 2.4.20 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.
I'he compiled a new 2.4.20 kernel for SMP and i get the next error when 
i reboot:

/lib/modules/2.4.20/kernel/drivers/net/8139too.o: unresolved symbol 
synchronize_irq

I've compiled with SMP and RTC support for a Pentium Pro, and i haven't 
included APM support.
Any help????

Thanks

-- 
-------
Un saludo

Pablo Giménez Pizarro
-------
La única lucha que se pierde es la que se abandona.
(Mujeres de la Plaza de Mayo)
-------
Albion 3.0 Project: www.albion30.net




