Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUG0SMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUG0SMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUG0SMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:12:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:26288 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266532AbUG0SKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:10:37 -0400
Date: Tue, 27 Jul 2004 10:50:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-Id: <20040727105039.052352d8.rddunlap@osdl.org>
In-Reply-To: <200407271402.59846.gene.heskett@verizon.net>
References: <200407271233.04205.gene.heskett@verizon.net>
	<200407271343.43583.gene.heskett@verizon.net>
	<20040727103256.2691d6f9.rddunlap@osdl.org>
	<200407271402.59846.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 14:02:59 -0400 Gene Heskett wrote:

| On Tuesday 27 July 2004 13:32, Randy.Dunlap wrote:
| [...]
| Gene Heskett wrote:
| >| I take it that I should apply these to a 2.6.7 tarballs tree in
| >| this order:
| >| 1. 2.6.8-rc1
| >|
| >>>>> 2.6.8-rc2 <<<<<
| 2.6.8-rc2?  These patches I got will need to be reverted then?

Nope, my bad.  I didn't read $Subject... please continue....

| >| 2. each of these 'rc2-bk' patches by the day and then run each for
| >| a couple days, or should I start in the middle, say the 3rd one
| >| and work forward or backwards from there depending on the results?
| >
| >I'd suggest beginning with -bk3 and doing a binary search.
| 
| Ok, as soon as the kde build exits (and it will, bet the whole farm on 
| it)  I'll give it a try.
| 
| >| Your (and Viro's) call.  I'd imagine you would want to run this to
| >| earth as quick as we can.
| >|
| >| Are these patches cumulative?  I presume they are as they grow by
| >| the day.
| >
| >Sorry, I should have mentioned that.  Yes, they are cumulative.
| 
| Well, it was a pretty obvious conclusion :)


--
~Randy
