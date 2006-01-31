Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWAaTCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWAaTCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWAaTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:02:31 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:12038 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1751354AbWAaTCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:02:31 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org, sander@humilis.net
Subject: Re: [OT] 8-port AHCI SATA Controller?
Date: Tue, 31 Jan 2006 10:02:10 -0900
User-Agent: KMail/1.7.2
Cc: jgarzik@pobox.com
References: <20060131115343.GA2580@favonius> <200601310919.20199.joshua.kugler@uaf.edu> <20060131185646.GF6178@favonius>
In-Reply-To: <20060131185646.GF6178@favonius>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311002.11091.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 09:56, Sander wrote:
> Joshua Kugler wrote (ao):
> > http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm
> >
> > They also have a 3.0Gb version.
> Marvell has their own chipset, according to
> http://linux.yyz.us/sata/sata-status.html#marvell

They do, but I could never find them.  At least, not that made sense to me.  
The mvSata_Linux drivers were the GPL'ed, and then "extended" versions, IIRC.  
It's been a while since I've researched that.

> > I got the drivers here:
> > http://www.keffective.com/mvsata/FC3/
> > The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.
> I very, very much prefer in-tree drivers :-)

I do too.  However, I was trying to use a Supermicro P4SCi motherboard and it 
*would not boot* with two SX8 cards and more than 8 SATA drives hooked up, 
regardless of configuration (7 on one card, 2 on the other, etc). So, I had 
to find another eight port card.  And besides, the MV8's are about half the 
price of the SX8's. :)  So I went with what worked.

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
