Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUHZKOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUHZKOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUHZKA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:00:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:59595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268065AbUHZJwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:52:18 -0400
Date: Thu, 26 Aug 2004 02:49:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Spam <spam@tnonline.net>
Cc: wichert@wiggy.net, jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826024956.08b66b46.akpm@osdl.org>
In-Reply-To: <1939276887.20040826114028@tnonline.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
	<20040825163225.4441cfdd.akpm@osdl.org>
	<20040825233739.GP10907@legion.cup.hp.com>
	<20040825234629.GF2612@wiggy.net>
	<1939276887.20040826114028@tnonline.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:
>
>    Yes,  for  example  documents,  image  files  etc. The multiple data
>    streams  can  contain thumbnails, info about who is editing the file
>    (useful for networked files) etc. Could be used for version handling
>    and much more.

All of which can be handled in userspace library code.

What compelling reason is there for doing this in the kernel?
