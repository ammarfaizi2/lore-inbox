Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVGZX5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVGZX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVGZXy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:54:57 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:23965 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262297AbVGZXxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:53:49 -0400
Message-ID: <29407.134.134.136.2.1122422050.squirrel@chretien.genwebhost.com>
In-Reply-To: <20050726163521.73c7ed08.akpm@osdl.org>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
    <42E692E4.4070105@m1k.net>
    <20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
    <42E69C5B.80109@m1k.net> <20050726144149.0dc7b008.akpm@osdl.org>
    <20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
    <20050726161149.0c9c36fa.akpm@osdl.org>
    <20050727012558.5661d071.astralstorm@gorzow.mm.pl>
    <20050726163521.73c7ed08.akpm@osdl.org>
Date: Tue, 26 Jul 2005 16:54:10 -0700 (PDT)
Subject: Re: MM kernels - how to keep on the bleeding edge?
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Radoslaw AstralStorm Szkodzinski" <astralstorm@gorzow.mm.pl>,
       mkrufky@m1k.net, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton said:
> Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
>>
>> On Tue, 26 Jul 2005 16:11:49 -0700
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>> >
>> > All done - let me know if it needs anything else.
>> >
>>
>> You got me with a tarball w/o a directory inside. Now I have to clean
>> up the mess.
>> Not the first time in life. I think I'll never learn. :)
>
> I did?

I thought that he meant without a top-level directory...


> bix:/home/akpm/.mm> tar tvfj broken-out-2005-07-26-15-07.tar.bz2 | head
> -rw-r--r-- akpm/akpm     35426 2005-07-26 15:10:32 series
> -rw-r--r-- akpm/akpm    593326 2005-07-26 12:46:37 patches/linus.patch
> -rw-r--r-- akpm/akpm      3076 2005-07-16 14:28:43
> patches/i2c-mpc-restore-code-removed.patch
> -rw-r--r-- akpm/akpm       888 2005-07-16 14:28:45
> patches/really-__nocast-annotate-kmalloc_node.patch
> -rw-r--r-- akpm/akpm      3071 2005-07-26 00:37:34
> patches/mips-fbdev-kconfig-fix.patch
> -rw-r--r-- akpm/akpm      4097 2005-07-26 00:37:34
> patches/max_user_rt_prio-and-max_rt_prio-are-wrong.patch
> -rw-r--r-- akpm/akpm      2053 2005-07-26 00:39:53
> patches/md-when-resizing-an-array-we-need-to-update-resync_max_sectors-as-well-as-size.patch
> -rw-r--r-- akpm/akpm       946 2005-07-26 00:39:55
> patches/uml-readd-missing-define-to-arch-um-makefile-i386.patch


-- 
~Randy

