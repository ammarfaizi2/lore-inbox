Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWGGVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWGGVap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWGGVap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:30:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37136 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932315AbWGGVao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:30:44 -0400
Date: Fri, 7 Jul 2006 21:30:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Bill Davidsen <davidsen@tmr.com>, Benny Amorsen <benny+usenet@amorsen.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060707213030.GA5393@ucw.cz>
References: <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com> <20060707141030.GC4239@ucw.cz> <m38xn58g26.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38xn58g26.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-06 19:45:21, Krzysztof Halasa wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > It *was* done. mc supports undelete on ext2.
> 
> How does it do that? Directly accessing the device?

Yes. I used it once or twice, and was not happy when ext3 broke it.

-- 
Thanks for all the (sleeping) penguins.
