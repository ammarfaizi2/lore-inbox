Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSLWWG6>; Mon, 23 Dec 2002 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSLWWG6>; Mon, 23 Dec 2002 17:06:58 -0500
Received: from smtp1.libero.it ([193.70.192.51]:62091 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S266996AbSLWWG5> convert rfc822-to-8bit;
	Mon, 23 Dec 2002 17:06:57 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Gabriele Riva <gabriva@libero.it>
To: linux-kernel@vger.kernel.org
Subject: kernel version 2.5.52 / Slackware8.1
Date: Mon, 23 Dec 2002 23:16:15 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212232316.15781.gabriva@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support chipset audio VIA VT8233

error:  
...
ld -m elf_i386  -r -o sound/pci/ac97/snd-ac97-codec.o 
sound/pci/ac97/ac97_codec.o sound/pci/ac97/ac97_patch.o
   ld -m elf_i386  -r -o sound/pci/ac97/built-in.o 
sound/pci/ac97/snd-ac97-codec.o
make -f scripts/Makefile.build obj=sound/pci/ali5451
   rm -f sound/pci/ali5451/built-in.o; ar rcs sound/pci/ali5451/built-in.o
make -f scripts/Makefile.build obj=sound/pci/cs46xx
   rm -f sound/pci/cs46xx/built-in.o; ar rcs sound/pci/cs46xx/built-in.o
make -f scripts/Makefile.build obj=sound/pci/emu10k1
   rm -f sound/pci/emu10k1/built-in.o; ar rcs sound/pci/emu10k1/built-in.o
make -f scripts/Makefile.build obj=sound/pci/ice1712
   rm -f sound/pci/ice1712/built-in.o; ar rcs sound/pci/ice1712/built-in.o
make -f scripts/Makefile.build obj=sound/pci/korg1212
   rm -f sound/pci/korg1212/built-in.o; ar rcs sound/pci/korg1212/built-in.o
make -f scripts/Makefile.build obj=sound/pci/nm256
   rm -f sound/pci/nm256/built-in.o; ar rcs sound/pci/nm256/built-in.o
make -f scripts/Makefile.build obj=sound/pci/rme9652
   rm -f sound/pci/rme9652/built-in.o; ar rcs sound/pci/rme9652/built-in.o
make -f scripts/Makefile.build obj=sound/pci/trident
   rm -f sound/pci/trident/built-in.o; ar rcs sound/pci/trident/built-in.o
make -f scripts/Makefile.build obj=sound/pci/ymfpci
   rm -f sound/pci/ymfpci/built-in.o; ar rcs sound/pci/ymfpci/built-in.o
   ld -m elf_i386  -r -o sound/pci/built-in.o sound/pci/snd-via82xx.o 
sound/pci/ac97/built-in.o sound/pci/ali5451/built-in.o 
sound/pci/cs46xx/built-in.o sound/pci/emu10k1/built-in.o 
sound/pci/korg1212/built-in.o sound/pci/nm256/built-in.o 
sound/pci/rme9652/built-in.o sound/pci/trident/built-in.o 
sound/pci/ymfpci/built-in.o sound/pci/ice1712/built-in.o
make -f scripts/Makefile.build obj=sound/ppc
   rm -f sound/ppc/built-in.o; ar rcs sound/ppc/built-in.o
make -f scripts/Makefile.build obj=sound/sparc
   rm -f sound/sparc/built-in.o; ar rcs sound/sparc/built-in.o
make -f scripts/Makefile.build obj=sound/synth
make -f scripts/Makefile.build obj=sound/synth/emux
   ld -m elf_i386  -r -o sound/synth/built-in.o sound/synth/emux/built-in.o
ld: cannot open sound/synth/emux/built-in.o: No such file or directory
make[2]: *** [sound/synth/built-in.o] Error 1
make[1]: *** [sound/synth] Error 2
make: *** [sound] Error 2


tanks
Gabriele
Italy
