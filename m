Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268423AbUIFSMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268423AbUIFSMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUIFSMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:12:00 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:9526 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S268423AbUIFSLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:11:51 -0400
Subject: Re: [BUG] r200 dri driver deadlocks
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, dri-devel@lists.sf.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d577e569040906040147c2277f@mail.gmail.com>
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
	 <1094429682.29921.6.camel@krustophenia.net>
	 <d577e569040906040147c2277f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 06 Sep 2004 14:12:08 -0400
Message-Id: <1094494329.31464.187.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 07:01 -0400, Patrick McFarland wrote:
> On Sun, 05 Sep 2004 20:14:43 -0400, Lee Revell <rlrevell@joe-job.com> wrote:
> > How to fix this is a pretty hot topic now.
> 
> Yow, I didn't mean to cause such an upset. ;)
> 
> Currently, the dri cvs snapshot for 20040905 doesn't compile with
> 2.6.8.1 for me (I've sent
> a bug report to the dri-devel mailing list about this) so Lee and
> Michel, you'll have to wait
> until tomorrow (or maybe even the day after that) to see how the test goes.

You can test the r200_dri.so from the snapshot with the DRM from the
kernel...


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
