Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265755AbUFIMXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUFIMXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUFIMXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:23:18 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:24078 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265755AbUFIMUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:20:43 -0400
Date: Wed, 9 Jun 2004 20:15:02 +0800 (WST)
From: raven@themaw.net
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and umount -f
In-Reply-To: <1086710357.3896.11.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.58.0406092013360.2821@donald.themaw.net>
References: <20040608155414.GA3975@thumper2> <1086710357.3896.11.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, RCVD_IN_ORBS, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Trond Myklebust wrote:

> På ty , 08/06/2004 klokka 11:54, skreiv Andy:
> > Why does this NOT do what is should be doing, i.e. umount no matter what?
> > 
> > Sometimes I get 
> > 
> > umount2 : Stale NFS file handle
> > umount : machine/path: Illegal seek
> > 
> > and it does not umount it.
> > 
> > What part of
> >  -f "Force unmount (in case of unreachable NFS system)" (umount man page)
> > 
> > does linux not understand?
> 
> Works for me...

And doesn't always work unconditionaly on other OSes either. 

So maybe that's life.

Ian

