Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbTHMG1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271411AbTHMG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:27:18 -0400
Received: from f16.mail.ru ([194.67.57.46]:49930 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S271410AbTHMG1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:27:16 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Norbert Preining=?koi8-r?Q?=22=20?= 
	<preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 13 Aug 2003 10:27:06 +0400
In-Reply-To: <20030813061546.GB24994@gamma.logic.tuwien.ac.at>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mp6A-000Osj-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


congratulations :)

-----Original Message-----

> 
> On Die, 12 Aug 2003, Christian Mautner wrote:
> > Hast du auch einen kompletten Kernel tarball versucht? Wahrscheinlich
> 
> The solution is:
> 	Get a COMPLETE linux-2.6.0-test3.tar.bz2
> and 
> 	DO NOT USE patch
> 
> I patched up the kernel from 2.5.20 or something and there seemed to be
> an error somewhere on the way up. Getting a *clean* kernel tar file,
> compile with the same .config, running.
> 
> This is the use of patches!
> 

well, I always do make distclean after patch ... I cannot afford
loading 30MB every week.


