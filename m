Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTJORpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTJORps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:45:48 -0400
Received: from windsormachine.com ([206.48.122.28]:9947 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263811AbTJORpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:45:44 -0400
Date: Wed, 15 Oct 2003 13:45:41 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
In-Reply-To: <200310151738.55113.schlicht@uni-mannheim.de>
Message-ID: <Pine.LNX.4.56.0310151342550.12914@router.windsormachine.com>
References: <20031014105514.GH765@holomorphy.com> <20031015132824.GS16158@holomorphy.com>
 <3F8D52CD.2000909@katana-technology.com> <200310151738.55113.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Thomas Schlichter wrote:

> I had one report of a person using mem= to reduce memory size for
> a broken i386 chipset thaty only supports 64MB cached and the rest
> as mtd/slram device for swap.  I got broken as the boundaries changed.

The 430FX, HX, VX, and TX ones?

There's also some VIA/Ali/etc chipsets of that same era that have cache
ram limits as well.

Found a good page listing all the limits while looking up info
yesterday, from when PC Chips was pirating BIOS code, for a discussion
going on over at one of the storagereview.com forums

Mike
