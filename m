Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S312619AbSELL1W>; Sun, 12 May 2002 07:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S312634AbSELL1V>; Sun, 12 May 2002 07:27:21 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:24721 "EHLO norma.kjist.ac.kr") by vger.kernel.org with ESMTP id <S312619AbSELL1R>; Sun, 12 May 2002 07:27:17 -0400
Message-ID: <3CDE5285.8030205@nospam.com>
Date: Sun, 12 May 2002 20:31:17 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am definitely a newbie as far as patch file handling is concerned.

I took the patch portion starting from

diff -ur 2.4.19-pre8-ac2/Makefile 2.4.19-pre8-ac2-test/Makefile

and ending with

MODVERFILE := $(TOPDIR)/include/linux/modversions.h

which is the last line,
and made it a file named Keith.patch.  Then, I went to /usr/src/linux
and issued

patch -p1 < Keith.patch

Well.... That did not work.  WHat did I do wrong?

Thanks a lot.

G. Hugh SOng

