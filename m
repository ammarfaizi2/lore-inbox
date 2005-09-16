Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbVIPTIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbVIPTIe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbVIPTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:08:34 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:427 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1161273AbVIPTId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:08:33 -0400
Date: Fri, 16 Sep 2005 21:08:31 +0200
From: Martin Mares <mj@ucw.cz>
To: Bodo Eggert <7eggert@gmx.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       =?iso-8859-2?B?Ik1hcnRpbiB2LiBM9ndpcyI=?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050916190831.GA3265@ucw.cz>
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N6EL-4Hq-5@gated-at.bofh.it> <4N6EK-4Hq-1@gated-at.bofh.it> <4N6EX-4Hq-27@gated-at.bofh.it> <4N6Ox-4Ts-33@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it> <E1EGKXl-0001Sn-GA@be1.lrz> <432B0A47.7060909@zytor.com> <Pine.LNX.4.58.0509162029470.5708@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509162029470.5708@be1.lrz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It should, but as long as old programs are still around, we'll have both 
> and need a marker to distinguish them.

I doubt that. For ages people were using several different encodings on
a single system (at least here in .cz) without any markers and although
there were some rough edges, almost everything worked. Now we do the same
with ISO-8859-2 and UTF-8, again with no need for a marker.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Linux vs. Windows is a no-WIN situation.
