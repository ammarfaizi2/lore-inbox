Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUH0IWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUH0IWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269062AbUH0IWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:22:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:65251 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268924AbUH0ITq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:19:46 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412EEB6D.80702@namesys.com>
Date: Fri, 27 Aug 2004 01:06:05 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>
>To me, a filesystem that allows this thing doesn't really _have_ the 
>concept of "directory vs file". It's just a "filesystem object", and it 
>can act as _both_ a directory and a file.
>
>  
>
I agree.
