Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbUKTEpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbUKTEpD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUKTEmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:42:09 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25504 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263111AbUKTEkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:40:17 -0500
Message-ID: <419ECAB5.10203@namesys.com>
Date: Fri, 19 Nov 2004 20:40:21 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
References: <16797.41728.984065.479474@samba.org>	<419E1297.4080400@namesys.com> <16798.31565.306237.930372@samba.org>
In-Reply-To: <16798.31565.306237.930372@samba.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can you describe qualitatively what your test does?  You didn't answer 
whether it does fsyncs, etc.

It might be worth testing it with the extents only mount option for reiser4.

Hans


