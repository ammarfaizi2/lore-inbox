Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTAYC4X>; Fri, 24 Jan 2003 21:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTAYC4X>; Fri, 24 Jan 2003 21:56:23 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:19213 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S266081AbTAYC4W>; Fri, 24 Jan 2003 21:56:22 -0500
Date: Sat, 25 Jan 2003 03:03:35 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: Thomas Tonino <ttonino@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with Qlogic 2200 and 2.4.20
In-Reply-To: <1043372733.12893.7.camel@localhost>
Message-ID: <Pine.LNX.4.44.0301250035130.32650-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2003, GrandMasterLee wrote:

> I think you'll have to qualify that with hardware type etc.

Tyan S2462NG, dual 1.7GHz Athlons (MP), QLA2310.

> As for the 6.x driver versions, so far, no instability,

Its stable for me with the RH 5.31-RH driver. With v6.x it can be 
easily locked up with heavy IO, eg multiple concurrent bonnie++'s. 
(might take a few hours sometimes though). Spins in the interrupt 
handler.

> of, but they never stop loading. It's a pretty High load I'd say,
> could be higher though.

hmm.

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

