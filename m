Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRIEWjv>; Wed, 5 Sep 2001 18:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272350AbRIEWja>; Wed, 5 Sep 2001 18:39:30 -0400
Received: from mx3.port.ru ([194.67.57.13]:525 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S272345AbRIEWj2>;
	Wed, 5 Sep 2001 18:39:28 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109060302.f8632BP02164@vegae.deep.net>
Subject: more fruits, though not probably fresh
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Sep 2001 03:02:11 +0000 (UTC)
Cc: alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       Dunno if it already is fised in ac7 kernels but...

make[4]: Entering directory `/usr/src/linux-stest/drivers/scsi/aic7xxx/aicasm'
*** Install db development libraries
gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
aicasm_gram.y:1476: warning: type mismatch with previous implicit declaration
/usr/share/bison.simple:643: warning: previous implicit declaration of `yyerror'aicasm_gram.y:1476: warning: `yyerror' was previously implicitly declared to return `int'
aicasm_symbol.c:39: aicdb.h: No such file or directory
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/usr/src/linux-stest/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/usr/src/linux-stest/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-stest/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-stest/drivers'
make: *** [_mod_drivers] Error 2

cheers,
 Sam
