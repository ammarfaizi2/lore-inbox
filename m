Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTH2Pdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTH2Pdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:33:39 -0400
Received: from tmi.comex.ru ([217.10.33.92]:63636 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261384AbTH2Pcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:32:45 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 29 Aug 2003 19:38:12 +0400
In-Reply-To: <3F4F7129.1050506@wmich.edu> (Ed Sweetman's message of "Fri, 29
 Aug 2003 11:28:41 -0400")
Message-ID: <m3vfsgpj8b.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:

 ES> If it's the same as test2 then i've already tried it.  I got no
 ES> performance gains as far as dbench is concerned.  Perhaps my block
 ES> size is not optimal on that partition for extents.  Either way it
 ES> seemed to make the kernel unstable and i've been trying to fix things
 ES> since mid-day yesterday.  Been getting very strange problems, no error
 ES> messages are reported or anything like that.

I still use -test2, because -test4 detects my scsi hdds in another order
than -test2. last time I sent rediff against -test4. what kind of problem
did you see?

