Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUL2MKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUL2MKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUL2MKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:10:50 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:49895 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261298AbUL2MKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:10:45 -0500
Date: Wed, 29 Dec 2004 13:10:33 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229121033.GA10308@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost> <20041229015716.GB29323@wohnheim.fh-wedel.de> <20041229095129.GI24603@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041229095129.GI24603@wiggy.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 December 2004 10:51:30 +0100, Wichert Akkerman wrote:
> Previously Jörn Engel wrote:
> > On Wed, 29 December 2004 00:52:32 +0100, Jesper Juhl wrote:
> > > -static int cifs_relock_file(struct cifsFileInfo * cifsFile)
> > > +static int 
> > > +cifs_relock_file(struct cifsFileInfo *cifsFile)
> > 
> > Linus viciously prefers to keep return type and function name on a
> > single line.  I cannot quite follow his reasoning, but would leave
> > that part out, unless explicitly requested by Steve.
> 
> If they are on a single line grep will find the return type as well
> which is extremely convenient.

Ok, that reasoning I can follow.  Thanks, Wichert!

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
