Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264882AbUFCXxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264882AbUFCXxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUFCXxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:53:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:29067 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S264882AbUFCXxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:53:10 -0400
Date: Thu, 3 Jun 2004 16:53:07 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
Message-ID: <20040603165307.A26198@home.com>
References: <20040602201315.GA10339@devserv.devel.redhat.com> <40BE3F00.4090408@pobox.com> <20040602211646.GA9419@devserv.devel.redhat.com> <40BE4537.5030101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40BE4537.5030101@pobox.com>; from jgarzik@pobox.com on Wed, Jun 02, 2004 at 05:23:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:23:03PM -0400, Jeff Garzik wrote:
> Alan Cox wrote:
> > Most of our drivers don't work bigendian. If you want it bigendian you
> > can find someone to do it because I don't have the hardware to verify
> > bigendian and currently there probably isnt a single big endian user of this
> > chip on the planet.
> 
> 
> Well, there probably isn't a single user of this entire driver on the 
> planet outside of VIA and RH, yet.
> 
> I got the gbit part on a PCI card, and AFAIK via 10/100 stuffs have 
> always appeared on PCI cards as well as on-board ("LOM").

Who makes this PCI card with the via velocity gbit part on it?

-Matt
