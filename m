Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUHIMJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUHIMJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUHIMIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:08:30 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:275 "EHLO www.rubis.org")
	by vger.kernel.org with ESMTP id S266511AbUHIMHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:07:14 -0400
Date: Mon, 9 Aug 2004 14:07:06 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20040809120705.GA23073@diamant.rubis.org>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Filip Van Raemdonck <filipvr@xs4all.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040808191912.GA620@elf.ucw.cz> <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian> <1092046959.21815.15.camel@pegasus>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1092046959.21815.15.camel@pegasus>
X-Operating-System: Linux 2.6.8-rc3-mm2
X-Send-From: diamant.tech.sitadelle.com
User-Agent: Mutt/1.5.6+20040803i
X-SA-Exim-Connect-IP: 213.223.184.201
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: * -4.9 BAYES_00 BODY: L'algorithme  =?ISO-8859-1?Q?=20Bay=E9sien?= a  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?valu=E9?= la  =?ISO-8859-1?Q?=20probabilit=E9?= de spam entre 0 et 1%
	*      [score: 0.0000]
	*  0.5 AWL AWL: Auto-whitelist adjustment
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on www.rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 12:22:39PM +0200, Marcel Holtmann wrote:
> > > > I'm using USB bluetooth dongle for connecting with my cell phone... It
> > > > works in 2.6.7, but not in -rc2-mm1. Is that known?
> > > 
> > > not that I know of, but I need more details and first you should try the
> > > latest 2.6.8-rc3
> > 
> > Works here for USB dongle <-> cell phone. Dunno about the others.
> > So, it's not a general breakage (in that kernel version)
> 
> this is what I was thinking, because I always run the latest stuff from
> the Bitkeeper repository directly. Seems that there is something in the
> -mm patches that broke it. Can someone test the latest -mm and report if
> the Bluetooth subsystem is working or not?

Not working here since 2.6.8-rc2-mm2.
Works in 2.6.8-rc2-mm1.

debian sid up-to-date with latest bluez-utils.

I tried hidp only.

++

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy             X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
