Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVDGQeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVDGQeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVDGQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:34:17 -0400
Received: from palrel10.hp.com ([156.153.255.245]:53670 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262513AbVDGQeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:34:12 -0400
Date: Thu, 7 Apr 2005 09:34:11 -0700
To: Michal Rokos <michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IrDA] Oops with NULL deref in irda_device_set_media_busy
Message-ID: <20050407163411.GA14156@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <200504051102.27533.michal@rokos.info> <200504060922.49267.michal@rokos.info> <20050406164943.GA12518@bougret.hpl.hp.com> <200504070822.52704.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504070822.52704.michal@rokos.info>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.6+20040907i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 08:22:52AM +0200, Michal Rokos wrote:
> Hello,
> 
> On Wednesday 06 April 2005 18:49, Jean Tourrilhes wrote:
> >  Patch attached.
> 
> and is working fine - of course.
> 
> Thank you for patience. :)
> 
>  Michal

	No, thank you for pushing me harder ;-) Note that the comments
is in my mind more important than the patch, next time someone hack in
there, he will need to be aware of that. I've also decided that it was
harder to enforce an ordering on the driver...
	Have fun...

	Jean

