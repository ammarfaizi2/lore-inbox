Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUGGLXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUGGLXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUGGLXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:23:20 -0400
Received: from pop.gmx.de ([213.165.64.20]:46977 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263159AbUGGLXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:23:17 -0400
X-Authenticated: #547800
Message-ID: <002001c46415$4bb9dfe0$6bda6c50@b>
From: <sc2@gmx.at>
To: <linux-kernel@vger.kernel.org>
References: <S265049AbUGGKsc/20040707104832Z+1012@vger.kernel.org>
Subject: Re: question kernel 2.6 problem
Date: Wed, 7 Jul 2004 13:26:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello
when i try to make the 2.6.7 kernel this error is coming
i use gcc 3.2.1
any ideas what i did wrong? (i did same stuff likle every time)
thx
 CC      arch/i386/kernel/asm-offsets.s
In Datei, eingef?gt von include/asm/system.h:5,
                    von include/asm/processor.h:18,
                    von include/asm/thread_info.h:16,
                    von include/linux/thread_info.h:21,
                    von include/linux/spinlock.h:12,
                    von include/linux/capability.h:45,
                    von include/linux/sched.h:7,
                    von arch/i386/kernel/asm-offsets.c:7:
include/linux/kernel.h:10:20: stdarg.h: Datei oder Verzeichnis nicht
gefunden
In file included from include/asm/system.h:5,
                 from include/asm/processor.h:18,
                 from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/kernel.h:71: Fehler: parse error vor "va_list"
include/linux/kernel.h:71: Warnung: Funktionsdeklaration ist kein Prototyp
include/linux/kernel.h:74: Fehler: parse error vor "va_list"
include/linux/kernel.h:74: Warnung: Funktionsdeklaration ist kein Prototyp
include/linux/kernel.h:77: Fehler: parse error vor "va_list"
include/linux/kernel.h:77: Warnung: Funktionsdeklaration ist kein Prototyp
include/linux/kernel.h:81: Fehler: parse error vor "va_list"
include/linux/kernel.h:81: Warnung: Funktionsdeklaration ist kein Prototyp
make[1]: *** [arch/i386/kernel/asm-offsets.s] Fehler 1
make: *** [arch/i386/kernel/asm-offsets.s] Fehler 2


