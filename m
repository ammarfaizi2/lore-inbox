Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280075AbRJaFGy>; Wed, 31 Oct 2001 00:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280074AbRJaFGo>; Wed, 31 Oct 2001 00:06:44 -0500
Received: from 39.159.252.64.snet.net ([64.252.159.39]:640 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id <S280073AbRJaFGl>;
	Wed, 31 Oct 2001 00:06:41 -0500
Message-ID: <3BDF899D.7070503@stinkfoot.org>
Date: Wed, 31 Oct 2001 00:18:21 -0500
From: Ethan@stinkfoot.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PPC kernel ide modules failing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I thought that I'd mention that on recent PPC kernels the ide modules 
won't load:
/lib/modules/2.4.14-pre3/kernel/drivers/ide/ide-mod.o: unresolved symbol 
ppc_generic_ide_fix_driveid

/lib/modules/2.4.14-pre3/kernel/drivers/ide/ide-mod.o: unresolved symbol 
ppc_generic_ide_fix_driveid

This has been happening for quite some time, since around 2.4.2 or so. 
 I'm using:

gcc version 2.95.3 19991030 (prerelease/franzo/20001125)
binutils 2.11.2
glibc-2.2.4

please cc me any replies as I don't subscribe to the list.

thanks,

Ethan Weinstein


