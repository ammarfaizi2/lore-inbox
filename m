Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWGHKwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWGHKwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWGHKwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:52:20 -0400
Received: from khc.piap.pl ([195.187.100.11]:39316 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751305AbWGHKwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:52:19 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701181702.GC8763@irc.pl>
	<20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<44A9904F.7060207@wolfmountaingroup.com>
	<20060703232547.2d54ab9b.diegocg@gmail.com>
	<m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com>
	<20060707141030.GC4239@ucw.cz> <m38xn58g26.fsf@defiant.localdomain>
	<20060707213030.GA5393@ucw.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 08 Jul 2006 12:52:17 +0200
In-Reply-To: <20060707213030.GA5393@ucw.cz> (Pavel Machek's message of "Fri, 7 Jul 2006 21:30:31 +0000")
Message-ID: <m3odw0e5cu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> > It *was* done. mc supports undelete on ext2.
>> 
>> How does it do that? Directly accessing the device?
>
> Yes. I used it once or twice, and was not happy when ext3 broke it.

I'd say it had to be broken from the beginning. Doing such things
on live, mounted filesystem...
-- 
Krzysztof Halasa
