Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRGDLdv>; Wed, 4 Jul 2001 07:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRGDLdl>; Wed, 4 Jul 2001 07:33:41 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57263 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264303AbRGDLd1>;
	Wed, 4 Jul 2001 07:33:27 -0400
Message-ID: <3B42FF02.DD6E63ED@mandrakesoft.com>
Date: Wed, 04 Jul 2001 07:33:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.6-final changelog entry
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i summarized it for irc, so if it saves effort...

jg's 2.4.6-final changelog:
- minor config.in fixes
- mtd nand/spia update
- TI cardbus fix      
- u810 audio put_user fix
- ialloc.c fix, mode, plus DQUOT_INIT
- ELOOP in namei.c
- if (!mm) return in proc/base.c
- replace mm/mmap.c change:
free += swapper_space.nrpages;

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
