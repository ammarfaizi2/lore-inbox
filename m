Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSJPVoG>; Wed, 16 Oct 2002 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSJPVnW>; Wed, 16 Oct 2002 17:43:22 -0400
Received: from mail-infomine.ucr.edu ([138.23.89.48]:4061 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id <S261383AbSJPVmj>; Wed, 16 Oct 2002 17:42:39 -0400
Date: Wed, 16 Oct 2002 14:48:35 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre11aa1 Compile Error
Message-ID: <20021016214835.GA6510@mail-infomine.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'
gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.4.20pre11aa1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c:70: `dest_LowestPrio' undeclared here (not in a function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'

.config upon request.
-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"To understand recursion, one must first understand recursion."
              -- Unknown

