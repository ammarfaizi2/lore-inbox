Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSIXBGG>; Mon, 23 Sep 2002 21:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSIXBGG>; Mon, 23 Sep 2002 21:06:06 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:22401 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S261514AbSIXBGF> convert rfc822-to-8bit; Mon, 23 Sep 2002 21:06:05 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: me@ohdarn.net, <sct@redhat.com>
Subject: Re: [BENCHMARK] EXT2 vs EXT3 System calls via oprofile using contest 0.34
Date: Mon, 23 Sep 2002 20:11:35 -0400
User-Agent: KMail/1.4.6
Cc: <akpm@digeo.com>, <conman@kolivas.net>, <linux-kernel@vger.kernel.org>
References: <200209190142.58122.spstarr@sh0n.net> <20020923223429.V11682@redhat.com> <45680.65.185.109.125.1032825987.squirrel@ohdarn.net>
In-Reply-To: <45680.65.185.109.125.1032825987.squirrel@ohdarn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209232011.35383.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the patch is 'stable' I'd like to bench/test it.

On September 23, 2002 08:06 pm, Michael Cohen wrote:
> >> c0164910 26375    7.2638      ext3_do_update_inode
> >> /lib/modules/2.4.20-pre7-rmap14a-xfs-uml-shawn12d/build/vmlinux
> >
> > I've got a fix for excessive CPU time spent here.
>
> Could you pass that around? or is it not ready for general consumption... ?
> Thanks.
>
>
> ------
> Michael Cohen

