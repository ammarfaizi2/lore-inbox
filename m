Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUFRUCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUFRUCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUFRT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:59:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36034 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266764AbUFRTui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:50:38 -0400
Date: Fri, 18 Jun 2004 15:52:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christophe Saout <christophe@saout.de>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
In-Reply-To: <1087586532.9085.1.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.58.0406181549160.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr> 
 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com> 
 <1087585251.13235.3.camel@leto.cs.pocnet.net> <1087586532.9085.1.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Christophe Saout wrote:

> Am Fr, den 18.06.2004 um 21:00 Uhr +0200 schrieb Christophe Saout:
>
> > > 	It's a known issue currently being tracked with the bugzilla entry
> > > at http://bugzilla.kernel.org/show_bug.cgi?id=1671
> >
> > Hey, nice.
> >
> > I've got a nearly 100% reproducability of the problem here (FAM +
> > nautilus + hal.hotplug or something like that, I'm always getting this
> > Oops in nautilus trying to do something with its trash folder when I'm
> > mounting a remote volume). I'll try this patch and tell you if it's
> > working (for me).
>
> Well, it's not. :(
>
> The oops is gone but the processes are still hanging. I'm posting the
> SysRq-T trace on bugzilla. Hope it helps. If you need some help
> debugging the problem, please tell me if I can do something.

Ah ok, thanks for testing it, i'll have a new patch up later on.

	Zwane
