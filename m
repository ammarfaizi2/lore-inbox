Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUHJPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUHJPjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUHJPhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:37:03 -0400
Received: from jabberwock.ucw.cz ([81.31.5.130]:53473 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id S267488AbUHJPg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:36:27 -0400
Date: Tue, 10 Aug 2004 17:36:10 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dwmw2@infradead.org, James.Bottomley@steeleye.com,
       alan@lxorguk.ukuu.org.uk, axboe@suse.de, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810153610.GA19005@kam.mff.cuni.cz>
References: <200408101515.i7AFFwGs014308@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101515.i7AFFwGs014308@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> As the people who did create the bastardized version of cdrecord
> you are using did not make clear where the official defaults file
> for cdrecord is located, they did violate the license of cdrecord.

What part of the license exactly?

Also, if they modified the location of the file (which is reasonable
if the default location doesn't conform to they filesystem layout),
they should make clear where the _new_ location is, mentioning the
original one is completely irrelevant.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"One single semicolon. A perfect drop of perliness. The rest is padding." -- S. Manandhar
