Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUH0I1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUH0I1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUH0I1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:27:13 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10438 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269193AbUH0I0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:26:25 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412EEB75.1030401@namesys.com>
Date: Fri, 27 Aug 2004 01:06:13 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org> <412E33D6.5020500@slaphack.com>
In-Reply-To: <412E33D6.5020500@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are you guys even considering going to any pain at all to distort 
semantics for the sake of backup?  tar is easy, we'll fix it and send in 
a patch. 
