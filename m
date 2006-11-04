Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWKDUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWKDUHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965615AbWKDUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:07:23 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:4566 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964855AbWKDUHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:07:21 -0500
Date: Sat, 4 Nov 2006 21:07:20 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: dean gaudet <dean@arctic.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061104200720.GA14889@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org> <20061104105302.GB16991@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611040313280.28640@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611040313280.28640@twinlark.arctic.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 November 2006 03:13:46 -0800, dean gaudet wrote:
> On Sat, 4 Nov 2006, Jörn Engel wrote:
> 
> > You really don't want to go down that path.  Doubling the storage size
> > will double the work necessary to move old objects - hard to imagine a
> > design that scales worse.
> 
> there's no doubling of storage size required.

Oh, I double my storage size every few years when I buy a new disk.
And I would hate it if my filesystem became slower each time.

Jörn

-- 
Joern's library part 13:
http://www.chip-architect.com/
