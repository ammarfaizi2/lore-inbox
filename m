Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTJBOOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTJBOOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:14:17 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:52451 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263345AbTJBOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:14:00 -0400
Message-ID: <3F7C3280.7020803@daniel-luebke.de>
Date: Thu, 02 Oct 2003 16:13:20 +0200
From: Daniel Luebke <lkml@daniel-luebke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: de-de, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System Freeze with Kernel 2.6.0-test5 and PCMCIA 3Com
References: <3F704FAF.8050000@daniel-luebke.de>
In-Reply-To: <3F704FAF.8050000@daniel-luebke.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo list,

I tried many kernels in the last time and I have found that the error is 
somewhere different but I don't know where:
- compiled 2.6.0-test6 -> same error
- compiled 2.6.0-test6-bk1 -> same error

Ok, so I thought, 2.6. does not work, so try 2.4

- compiled 2.4.22 -> same error

Hmm, estonishing, but hey, 2.4.21-debian worked, so compile 2.4.21 
yourself, but

- compiled 2.4.21 -> same error

I really don't have any ideas anymore. Does anyone here has an idea?

Compiler is
gcc (GCC) 3.3.2 20030908 (Debian prerelease)
GNU Make 3.80

thanks

Daniel

