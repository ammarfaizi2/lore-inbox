Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUCaRL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUCaRLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:11:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:32483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbUCaRLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:11:02 -0500
Date: Wed, 31 Mar 2004 09:07:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lmb@suse.de, jgarzik@pobox.com,
       neilb@cse.unsw.edu.au, gibbs@scsiguy.com, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-Id: <20040331090754.7e12acef.rddunlap@osdl.org>
In-Reply-To: <200403261319.28858.kevcorry@us.ibm.com>
References: <760890000.1079727553@aslan.btc.adaptec.com>
	<40632804.1020101@pobox.com>
	<20040325220434.GW15264@marowsky-bree.de>
	<200403261319.28858.kevcorry@us.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 13:19:28 -0600 Kevin Corry wrote:

| On Thursday 25 March 2004 4:04 pm, Lars Marowsky-Bree wrote:
| > On 2004-03-25T13:42:12,
| >
| >    Jeff Garzik <jgarzik@pobox.com> said:
| > > >and -5). And we've talked for a long time about wanting to port RAID-1
| > > > and RAID-5 (and now RAID-6) to Device-Mapper targets, but we haven't
| > > > started on any such work, or even had any significant discussions about
| > > > *how* to do it. I can't
| > >
| > > let's have that discussion :)
| >
| > Nice 2.7 material, and parts I've always wanted to work on. (Including
| > making the entire partition scanning user-space on top of DM too.)
| 
| Couldn't agree more. Whether using EVMS or kpartx or some other tool, I think 
| we've already proved this is possible. We really only need to work on making 
| early-userspace a little easier to use.
| 
| > KS material?
| 
| Sounds good to me.

Ditto.

I didn't see much conclusion to this thread, other than Neil's
good suggestions.  (maybe on some other list that I don't read?)

I wouldn't want this or any other projects to have to wait for the
kernel summit.  Email has worked well for many years...let's
try to keep it working.  :)

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
