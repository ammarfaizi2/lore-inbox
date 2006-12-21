Return-Path: <linux-kernel-owner+w=401wt.eu-S1423076AbWLUUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423076AbWLUUyY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423091AbWLUUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:54:24 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40609 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423076AbWLUUyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:54:23 -0500
Date: Thu, 21 Dec 2006 21:52:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bill Davidsen <davidsen@tmr.com>
cc: Dave Jones <davej@redhat.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <4589BC6E.7040209@tmr.com>
Message-ID: <Pine.LNX.4.61.0612212151450.3720@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
 <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr> <4589BC6E.7040209@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 20 2006 17:42, Bill Davidsen wrote:
>
> Bearing in mind that some casts may have been put in when struct
> members had other values, may be needed on some hardware but not
> others, etc. Cleanups are good, but may not be as obvious as they
> appear.
>
> Not that there's a lack of places to remove visual cruft, but
> perhaps someone could look at casts and ask if each hides a real
> type mismatch.

http://lkml.org/lkml/2006/9/30/208

As much as I would like to go through the whole kernel tree, it's a
task quite big.


	-`J'
-- 
