Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932774AbVITRZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbVITRZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbVITRZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:25:35 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:13209 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932772AbVITRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:25:34 -0400
Message-ID: <43304606.6040608@namesys.com>
Date: Tue, 20 Sep 2005 10:25:26 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Pavel Machek <pavel@suse.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, vitaly@thebsh.namesys.com
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <43301FA0.7030906@slaphack.com>
In-Reply-To: <43301FA0.7030906@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
> And personally, if it was my FS, I'd stop working on fsck after it was
> able to "check".  That's what it's for.  To fix an FS, you wipe it and
> restore from backups.
>
>
Umm, this is going too far David.  Our fsck should work, and we will
give his script to Vitaly to play with and comment on.
