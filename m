Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUH0I1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUH0I1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUH0I1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:27:00 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10438 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269208AbUH0I02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:26:28 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412EEBE2.8090200@namesys.com>
Date: Fri, 27 Aug 2004 01:08:02 -0700
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
References: <Pine.LNX.4.44.0408261315240.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408261019580.2304@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>  
>
>No no. The stream you get from a directory is totally _independent_ of the 
>contents of the directory.
>
but the user can link filename/metas/body to filename/metas/tar, if we 
implement a tar plugin, if it happens that the user wants it to be 
totally dependent.

> Anything else would be pointless.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

