Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSFEQfQ>; Wed, 5 Jun 2002 12:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSFEQfP>; Wed, 5 Jun 2002 12:35:15 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:24822 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S315513AbSFEQfP>; Wed, 5 Jun 2002 12:35:15 -0400
Date: Wed, 5 Jun 2002 11:35:14 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: And one last build error (2.5.20)
Message-ID: <20020605113514.D2745@ksu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when making modules_install:
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.20/arch/i386/pci'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.20; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.20/kernel/drivers/acpi/thermal.o
depmod:         acpi_processor_set_thermal_limit
make: [_modinst_post] Error 1 (ignored)

-- 
Joseph======================================================jap3003@ksu.edu
"Ich bin ein Penguin."  --/. poster mmarlett, responding to news that the
  Bundestag will move to IBM/SuSE Linux.  
                      http://slashdot.org/comments.pl?sid=33588&cid=3631032
