Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTABBa2>; Wed, 1 Jan 2003 20:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTABBa2>; Wed, 1 Jan 2003 20:30:28 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:40711 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S265361AbTABBa1>; Wed, 1 Jan 2003 20:30:27 -0500
Date: Thu, 2 Jan 2003 01:38:45 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Jakma <paul@clubi.ie>, Rik van Riel <riel@conectiva.com.br>,
       <Hell.Surfers@cwctv.net>, <linux-kernel@vger.kernel.org>, <rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.44.0301011720300.21656-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0301020136020.30005-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, David Lang wrote:
> On Thu, 2 Jan 2003, Paul Jakma wrote:

> > further, the kernel's licence explicitely exempts the 'normal system
> > calls', and kernel headers describing these can quite arguably be
> > considered to fall within this exemption.
> 
> this is exactly the reasoning that nvidia uses to justify their use of the
> headers.

a kernel module does not make of use of the calls the exemption refers
to. it calls exported /kernel/ functions.

> you can't have it both ways.
> 
> David Lang

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

