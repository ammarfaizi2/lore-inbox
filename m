Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUHRPCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUHRPCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUHRPCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:02:25 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:59046 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S266805AbUHRPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:02:23 -0400
Subject: Re: libata (ICH5/6) patches for 2.4.27?
From: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Reply-To: christian.guggenberger@physik.uni-regensburg.de
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20040818055148.GE1456@alpha.home.local>
References: <1092760052.1765.8.camel@localhost>
	 <20040817185706.GA7325@mars.ravnborg.org>
	 <20040818055148.GE1456@alpha.home.local>
Content-Type: text/plain
Message-Id: <1092841324.1828.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 17:02:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 07:51, Willy Tarreau wrote:
> On Tue, Aug 17, 2004 at 08:57:06PM +0200, Sam Ravnborg wrote:
> > On Tue, Aug 17, 2004 at 06:27:32PM +0200, Christian Guggenberger wrote:
> > > Hi,
> > > 
> > > I'm looking for libata patches against 2.4.27. Well, I know these are
> > > already in 2.4.28-pre1, but I'd really appreciate to get pristine
> > > patches for 2.4.27. 
> > 
> > Take a look at:
> > linux.bkbits.net/linux-2.4
> > 
> > For a given cset you will find a link to an ordinary diff you can apply.
> 
> you can also get the patches from Jeff's directory on kernel.org :
> 
>    http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/
> 

ah thanks, that's what I've been looking for. I must have been blind...
I only looked at the usual libata patch dir in 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata . Seems
that the location changed since several libata bits have been merged in
2.4.27.

cheers.
  - Christian



