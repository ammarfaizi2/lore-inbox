Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUFTAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUFTAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUFTAe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:34:26 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:59877 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264791AbUFTAeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:34:24 -0400
Date: Sat, 19 Jun 2004 20:36:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christophe Saout <christophe@saout.de>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
In-Reply-To: <1087691335.19685.1.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.58.0406192035590.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr> 
 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com> 
 <1087585251.13235.3.camel@leto.cs.pocnet.net>  <1087586532.9085.1.camel@leto.cs.pocnet.net>
  <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com> 
 <Pine.LNX.4.58.0406191648240.2228@montezuma.fsmlabs.com> 
 <Pine.LNX.4.58.0406191946360.2228@montezuma.fsmlabs.com>
 <1087691335.19685.1.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Christophe Saout wrote:

> Am Sa, den 19.06.2004 um 20:27 Uhr -0400 schrieb Zwane Mwaikambo:
>
> > > > This is an updated debugging patch (which is also added to Bugzilla),
> > > > please give this a spin. There are still a few issues with this patch but
> > > > lets try at least avoid oopsing for now.
> > >
> > > Hold on, this is buggy garbage. i'll have something in a bit.
> >
> > Index: linux-2.6.7/include/linux/smb_fs_sb.h
> > ===================================================================
> > RCS file: /home/cvsroot/linux-2.6.7/include/linux/smb_fs_sb.h,v
>
> Ha! Success! :-)

Great, and Nautilus is happy? By the way, which OS is the SMB server?

