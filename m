Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUFSUrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUFSUrC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFSUrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:47:02 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:32214 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264650AbUFSUq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:46:59 -0400
Date: Sat, 19 Jun 2004 16:49:02 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christophe Saout <christophe@saout.de>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
In-Reply-To: <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr> 
 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com> 
 <1087585251.13235.3.camel@leto.cs.pocnet.net> <1087586532.9085.1.camel@leto.cs.pocnet.net>
 <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Zwane Mwaikambo wrote:

> On Fri, 18 Jun 2004, Christophe Saout wrote:
>
> > Well, it's not. :(
> >
> > The oops is gone but the processes are still hanging. I'm posting the
> > SysRq-T trace on bugzilla. Hope it helps. If you need some help
> > debugging the problem, please tell me if I can do something.
>
> This is an updated debugging patch (which is also added to Bugzilla),
> please give this a spin. There are still a few issues with this patch but
> lets try at least avoid oopsing for now.

Hold on, this is buggy garbage. i'll have something in a bit.

