Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289919AbSAWRNj>; Wed, 23 Jan 2002 12:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSAWRNT>; Wed, 23 Jan 2002 12:13:19 -0500
Received: from ppp-44-157.24-151.libero.it ([151.24.157.44]:18305 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S289917AbSAWRNI>; Wed, 23 Jan 2002 12:13:08 -0500
Message-Id: <200201241414.g0OEEQO06244@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: Guido Volpi <lugburz@tiscalinet.it>
To: linux-kernel@vger.kernel.org
Subject: problems to load kernel module on AMD 1800XP
Date: Thu, 24 Jan 2002 15:14:26 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My computer is ased on a motherboards MSI with k7266a chipset and 1800xp+ amd 
CPU, i have 512MB od DDR ram and my linux distribution is a Mandrake 8.1

My problem is when i try to compile 2.4.17 kernel fo athlon processors. The 
compilation proces don't have error but when i reboot the system and load 
this new kernel all modules fail the dependence for "_mmx_symbol". If i 
compile the kernel for generic 586/686 processor i don't have problem.

best regards

-- 
=============================================================================

...
e noi che siamo esseri liberi
un ciclo siamo macellati, un ciclo siamo macellai
un ciclo riempiamo gli arsenali e un ciclo riempiamo i granai
...

					Guerra e Pace (CCCP)

=============================================================================
