Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbSKQJdI>; Sun, 17 Nov 2002 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbSKQJdI>; Sun, 17 Nov 2002 04:33:08 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:54491 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S267469AbSKQJdH>; Sun, 17 Nov 2002 04:33:07 -0500
Message-ID: <3DD763E8.9030401@drugphish.ch>
Date: Sun, 17 Nov 2002 10:39:52 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47: Linking errors with make modules_install
References: <20021117095753.01548e7a.starfire@dplanet.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After having compiled the kernel and the modules without problems, make
> modules_install gives the following error:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.47; fi
> depmod: *** Unresolved symbols in
> /lib/modules/2.5.47/kernel/fs/binfmt_aout.o
> depmod:         ptrace_notify

http://marc.theaimsgroup.com/?l=linux-kernel&m=103649573231775&w=2

Regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

