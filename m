Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRIVTEv>; Sat, 22 Sep 2001 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271981AbRIVTEc>; Sat, 22 Sep 2001 15:04:32 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:34746 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271978AbRIVTEY>; Sat, 22 Sep 2001 15:04:24 -0400
Date: Sat, 22 Sep 2001 15:07:30 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac14
Message-ID: <20010922150730.A8407@zero>
In-Reply-To: <20010922032246.A7730@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010922032246.A7730@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Sat, Sep 22, 2001 at 03:22:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md.c:50: conflicting types for `sys_setsid'
/sys/linux-2.4.9-ac14-patch-build/include/asm/unistd.h:563: previous declaration of `sys_setsid'
make[3]: *** [md.o] Error 1
make[2]: *** [first_rule] Error 2
make[1]: *** [_subdir_md] Error 2
make: *** [_dir_drivers] Error 2

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
