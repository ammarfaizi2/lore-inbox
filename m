Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbQKAXIW>; Wed, 1 Nov 2000 18:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbQKAXIM>; Wed, 1 Nov 2000 18:08:12 -0500
Received: from pfaffben.user.msu.edu ([35.10.20.24]:33798 "EHLO
	pfaffben.user.msu.edu") by vger.kernel.org with ESMTP
	id <S131772AbQKAXIA>; Wed, 1 Nov 2000 18:08:00 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101234058.B1598@werewolf.able.es>
 <20001101235734.D10585@garloff.etpnet.phys.tue.nl>
 <200011012247.OAA19546@pizda.ninka.net>
Reply-To: pfaffben@msu.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
From: Ben Pfaff <pfaffben@msu.edu>
Date: 01 Nov 2000 18:07:53 -0500
In-Reply-To: "David S. Miller"'s message of "Wed, 1 Nov 2000 14:47:21 -0800"
Message-ID: <87bsvzs33q.fsf@pfaffben.user.msu.edu>
User-Agent: Chaos/1.13.1 EMY/1.13.9 (Art is long, life is short) Chao/1.14.1
 (Rokujizò) APEL/10.2 Emacs/20.7 (i386-debian-linux-gnu)
 MULE/4.0 (HANANOEN)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    Date: 	Wed, 1 Nov 2000 23:57:34 +0100
>    From: Kurt Garloff <garloff@suse.de>
> 
>    kgcc is a redhat'ism.
> 
> Debian has it too.

No, it uses the name gcc272:

blp:~(0)$ kgcc
bash: kgcc: command not found
blp:~(127)$ gcc272
gcc272: No input files
blp:~(1)$ cat /etc/debian_version 
woody
blp:~(0)$ 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
