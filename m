Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWHKSbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWHKSbT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWHKSbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:31:19 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:33704 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932178AbWHKSbS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:31:18 -0400
Subject: Re: Announcing free software graphics drivers for Intel i965
	chipset
From: Nicholas Miell <nmiell@comcast.net>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, keith.packard@intel.com,
       Linux-kernel@vger.kernel.org, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
In-Reply-To: <81b0412b0608110705y75cd5307vf73dd0b6ee107f81@mail.gmail.com>
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org> <1155190917.2349.4.camel@entropy>
	 <81b0412b0608110705y75cd5307vf73dd0b6ee107f81@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 11:31:03 -0700
Message-Id: <1155321063.2522.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 16:05 +0200, Alex Riesen wrote:
> On 8/10/06, Nicholas Miell <nmiell@comcast.net> wrote:
> > > > The Intel Open Source Technology Center graphics team is pleased to announce
> > > > the immediate availability of free software drivers for the Intel(r) 965
> > > > Express Chipset family graphics controller. These drivers include support
> > > > for 2D and 3D graphics features for the newest generation Intel graphics
> > > > architecture. The project Web site is http://IntelLinuxGraphics.org.
> > >
> ...
> >
> > More importantly, where's the source to intel_hal.so?
> >
> 
> ...and what'd break if the call to intel_hal_set_content_protection is omited?

Where's that call at?

All I saw were intel_hal_wm_pass and intel_hal_recalculate_urb_fence in
Mesa, both of which appear to be strictly optimizations.

-- 
Nicholas Miell <nmiell@comcast.net>

