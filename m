Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEBAIn>; Wed, 1 May 2002 20:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314139AbSEBAIm>; Wed, 1 May 2002 20:08:42 -0400
Received: from jalon.able.es ([212.97.163.2]:50626 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314138AbSEBAIl>;
	Wed, 1 May 2002 20:08:41 -0400
Date: Thu, 2 May 2002 02:08:35 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.19-pre7-jam9
Message-ID: <20020502000835.GC1698@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

New realease of this small collection of patches.
Changes:

- Some fixes have been added: getpid enchancements, mmx-sse fpu init,
  p4-xeon detection
- backport (well, nearly just 'back-copy') of the intel e100 and e1000
  drivers.

Why this ? Well, be sincere, just 'cause I need them...

Try and break it.

Thanks

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
