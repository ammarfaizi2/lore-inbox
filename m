Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSEAIzi>; Wed, 1 May 2002 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSEAIzh>; Wed, 1 May 2002 04:55:37 -0400
Received: from ulima.unil.ch ([130.223.144.143]:36998 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S290289AbSEAIzg>;
	Wed, 1 May 2002 04:55:36 -0400
Date: Wed, 1 May 2002 10:55:35 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.12 compil error
Message-ID: <20020501085535.GA14645@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry if it has altrady been posted: I have looked for it at google but
didn't found it...

make[2]: Entering directory `/usr/src/linux-2.5/arch/i386/lib'
/usr/src/linux-2.5/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall
iasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686  -- checksum.S
trstr.c usercopy.c > .depend
make[2]: Leaving directory `/usr/src/linux-2.5/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.5'
scripts/split-include include/linux/autoconf.h include/config
make: *** No rule to make target `/usr/src/linux-2.5/include/linux/sysv_fs_sb.h'

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
