Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRIXUYi>; Mon, 24 Sep 2001 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274950AbRIXUY3>; Mon, 24 Sep 2001 16:24:29 -0400
Received: from mithra.wirex.com ([65.102.14.2]:17424 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S274949AbRIXUYR>;
	Mon, 24 Sep 2001 16:24:17 -0400
Message-ID: <3BAF966C.8040906@wirex.com>
Date: Mon, 24 Sep 2001 13:24:12 -0700
From: Crispin Cowan <crispin@wirex.com>
Reply-To: Linux Security Module <linux-security-module@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linux Security Module <linux-security-module@wirex.com>
Subject: Re: Binary only module overview
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote

I'm composing a list of all existing binary only modules, 
and I got to a list of 26 different modules
... 
Hewlet Packard	- High level security modules (LSM) 
SGI		- High level security modules (LSM) 
Wirex		- High level security modules (LSM)

NOTE: To my knowledge, the above mentioned modules either do not exist 
or have not been released. The LSM patch itself is entirely GPL'd.

The debate thread 
http://mail.wirex.com/pipermail/linux-security-module/2001-September/002017.html 
that Greg KH referred to is about whether LSM (security) modules should 
ever be permitted to be proprietary. Some feel that all LSM modules 
should be OSD-compliant Open Source software, while others feel that LSM 
should continue the existing Linux module policy of permitting 
proprietary modules only if they do not require changes to the Linux 
kernel (which would make them a derived work of the kernel).

This post cc'd and reply-to'd to the LSM mailing list.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


