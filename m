Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUCZTUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbUCZTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:20:45 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33709 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263132AbUCZTUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:20:41 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Date: Fri, 26 Mar 2004 13:19:28 -0600
User-Agent: KMail/1.6
Cc: Lars Marowsky-Bree <lmb@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org
References: <760890000.1079727553@aslan.btc.adaptec.com> <40632804.1020101@pobox.com> <20040325220434.GW15264@marowsky-bree.de>
In-Reply-To: <20040325220434.GW15264@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261319.28858.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 March 2004 4:04 pm, Lars Marowsky-Bree wrote:
> On 2004-03-25T13:42:12,
>
>    Jeff Garzik <jgarzik@pobox.com> said:
> > >and -5). And we've talked for a long time about wanting to port RAID-1
> > > and RAID-5 (and now RAID-6) to Device-Mapper targets, but we haven't
> > > started on any such work, or even had any significant discussions about
> > > *how* to do it. I can't
> >
> > let's have that discussion :)
>
> Nice 2.7 material, and parts I've always wanted to work on. (Including
> making the entire partition scanning user-space on top of DM too.)

Couldn't agree more. Whether using EVMS or kpartx or some other tool, I think 
we've already proved this is possible. We really only need to work on making 
early-userspace a little easier to use.

> KS material?

Sounds good to me.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
