Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUGFPtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUGFPtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUGFPtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:49:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:30552 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263972AbUGFPti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:49:38 -0400
Subject: Re: quite big breakthrough in the BAD network performance, which
	mm6 did not fix
From: Redeeman <lkml@metanurb.dk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040706135303.GG20237@harddisk-recovery.com>
References: <1089070720.14870.6.camel@localhost>
	 <200407051754.38690.lkml@lpbproductions.com>
	 <1089120330.10626.8.camel@localhost>
	 <20040706135303.GG20237@harddisk-recovery.com>
Content-Type: text/plain
Date: Tue, 06 Jul 2004 17:49:37 +0200
Message-Id: <1089128977.10626.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 15:53 +0200, Erik Mouw wrote:
> On Tue, Jul 06, 2004 at 03:25:30PM +0200, Redeeman wrote:
> > i am aware of this, however, what i use to benchmark is kernel.org, as i
> > can see they have alot bandwith free.
> > if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> > with 200kb/s
> 
> That could be easily explained by the fact that the www.kernel.org ftp
> and http services are handled by different programs (vsftpd vs.
> Apache).
yeah it could.. however it isnt. because 2.6.5 can easily take 200kb/s
from kernel.org http, and it sound strange too, that with 2.6.7 ALL http
adresses only give 50kb/s, and with 2.6.5 it gives 200 :>
> 
> 
> Erik
> 

