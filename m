Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTAWSpP>; Thu, 23 Jan 2003 13:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbTAWSpP>; Thu, 23 Jan 2003 13:45:15 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:64523 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S264944AbTAWSpP>; Thu, 23 Jan 2003 13:45:15 -0500
Date: Thu, 23 Jan 2003 18:52:44 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with Qlogic 2200 and 2.4.20
In-Reply-To: <1043308435.8274.3.camel@localhost>
Message-ID: <Pine.LNX.4.44.0301231851080.31406-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2003, GrandMasterLee wrote:

> Just to chime in, are you using the qlogicfc driver that comes with
> the kernel? If so, Try using qlogic's 6.01 driver set instead and
> see if your problem goes away. I've had other problems, mostly stack
> related, but I've since found my fixes

hmm.. i'd be very interested in them. I have found the qlogic v6 
driver to dreadfully unstable under heavy load (eg multiple 
bonnie++'s) on SMP.

> GrandMasterLee

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

