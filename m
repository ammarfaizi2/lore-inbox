Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUH0SeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUH0SeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUH0SeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:34:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:65160 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266905AbUH0Sdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:33:54 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412F7D63.4000109@namesys.com>
Date: Fri, 27 Aug 2004 11:28:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: David Masover <ninja@slaphack.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>
>
>Currently I see no way to distinguish between the stuff
>that should be backed up and the stuff that shouldn't.
>
>  
>
We create filename/pseudos/backup, and that tells the archiver what to 
do.....
