Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270492AbTGSEwN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 00:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270491AbTGSEwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 00:52:13 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:55972 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S270492AbTGSEwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 00:52:12 -0400
Date: Sat, 19 Jul 2003 07:07:06 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: More 2.6.0-test1-ac2 issues / nvidia kernel module
Message-ID: <20030719050706.GA22990@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030718154918.GA27176@charite.de> <200307190413.56193.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307190413.56193.ianh@iahastie.local.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Hastie <ianh@iahastie.clara.net>:

> And that's the problem.  The new modprobe uses /etc/modprobe.conf
> rather than /etc/modules.conf.  In Debian you now need to put the
> component files into /etc/modprobe.d instead of /etc/modutils.

Thanks for the enlightenment!

> However the syntax appears to be mostly the same so the configuration
> files you already have should still work.

So a cp will do. I'll try that.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
