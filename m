Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFSW7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 18:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFSW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 18:59:41 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:1042 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261843AbTFSW7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 18:59:35 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Unix code in Linux
Date: Thu, 19 Jun 2003 23:13:34 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bctg2u$75s$1@news.cistron.nl>
References: <E19T87m-000367-SF@dirac.s-z.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1056064414 7356 62.216.29.200 (19 Jun 2003 23:13:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E19T87m-000367-SF@dirac.s-z.org>,
Neil Moore  <neil@s-z.org> wrote:
>
>Slashdotter lspd pointed this out in a recent thread, thereby
>demonstrating that slashdot isn't completely useless.
>
>Compare:
>  /usr/src/linux/arch/ia64/sn/io/ate_utils.c in Linux
>to:
>  unix/malloc.c in UNIX 6th Edition (page 25 of the Lions code,
>  lines 2522--2589)

BSD 4.3 and Unix V7 source is browsable online at
http://tamacom.com/unix/

Choose "V7" and search for "mfree".

The source being online is possible because the V1 - V7 source was
put under a BSD-like license by Caldera in 2002. A copy of the license
is still at ftp://minnie.tuhs.org/UnixArchive/Caldera-license.pdf

(there's much more at ftp://minnie.tuhs.org/UnixArchive/, including
V6, V7 and 2.11BSD source).

So, in this particular case this doesn't seem to be a problem.

Mike.

