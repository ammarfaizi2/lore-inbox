Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUCSViQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUCSViQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 16:38:16 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:28849 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262044AbUCSViN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 16:38:13 -0500
Message-ID: <405B681F.3050702@stesmi.com>
Date: Fri, 19 Mar 2004 22:37:35 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CDFS
References: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet> <Pine.LNX.4.53.0403191200120.3752@chaos>
In-Reply-To: <Pine.LNX.4.53.0403191200120.3752@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Script started on Fri Mar 19 12:01:38 2004
> # umount /mnt
> # umount /mnt
> umount: /mnt: not mounted
> # umount -t iso9660 /dev/cdrom /mnt
^^^^^^^^

use "mount" instead of "umount" to mount something.

> mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
>        or too many mounted file systems
> # exit
> Script done on Fri Mar 19 12:04:49 2004

// Stefan
