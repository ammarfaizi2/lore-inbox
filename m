Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTFKObu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFKObt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:31:49 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:38352
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S262015AbTFKObo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:31:44 -0400
Date: Wed, 11 Jun 2003 10:45:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: mru@users.sourceforge.net, Rene Engelhard <rene@rene-engelhard.de>,
       Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org
Subject: Re: Compatible Hardware (Was: Re: RealTek NIC on alpha?)
Message-ID: <20030611144526.GA31051@gtf.org>
References: <20030611091910.GD801@rene-engelhard.de> <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org> <yw1x4r2wu7vk.fsf@zaphod.guide> <20030611164200.55f399d2.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030611164200.55f399d2.gigerstyle@gmx.ch>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 04:42:00PM +0200, Marc Giger wrote:
> Hi All,
> 
> Since a long time I asking me, which PC-Hardware is compatible with Alpha's? All? Is it just a question if the driver exists for this architecture?
> I know that the Alpha's has the same buses and are also little Endian like Intel (right?).
> 
> So as example I could take an ATI Radeon or an Adaptec 29160 SCSI Controller, put it into an Alpha and it works?


Most PCI and AGP cards work.

Video controllers, PCI or AGP, are special.  They may or may not work,
depending on what's in their video BIOS.

	Jeff




