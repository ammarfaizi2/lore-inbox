Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316242AbSELA4s>; Sat, 11 May 2002 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316273AbSELA4r>; Sat, 11 May 2002 20:56:47 -0400
Received: from ns.crrstv.net ([209.128.25.4]:10374 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S316242AbSELA4n>;
	Sat, 11 May 2002 20:56:43 -0400
Date: Sat, 11 May 2002 21:56:40 -0300
From: "skidley" <skidley@crrstv.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8-ac2 compile error
Message-ID: <20020512005640.GA2171@crrstv.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[1]: Leaving directory `/home/kernel/linux/Documentation/DocBook'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
scripts/split-include include/linux/autoconf.h include/config
make -r -f .tmp_include_depends all
make[1]: Entering directory `/home/kernel/linux'
make[1]: .tmp_include_depends: No such file or directory
make[1]: *** No rule to make target `.tmp_include_depends'.  Stop.
make[1]: Leaving directory `/home/kernel/linux'
make: *** [.tmp_include_depends] Error 2
-- 
Chad Young
Linux User #195191 
