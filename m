Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDUV5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTDUV5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:57:09 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:52218 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262620AbTDUV5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:57:04 -0400
Date: Mon, 21 Apr 2003 15:04:37 -0700
From: Chris Wright <chris@wirex.com>
To: Valdis.Kletnieks@vt.edu
Cc: Zoltan NAGY <nagyz@piarista-kkt.sulinet.hu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: grsecurity in 2.5?
Message-ID: <20030421150437.B11883@figure1.int.wirex.com>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Zoltan NAGY <nagyz@piarista-kkt.sulinet.hu>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu> <200304212145.h3LLjRM8002371@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200304212145.h3LLjRM8002371@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Mon, Apr 21, 2003 at 05:45:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> On Mon, 21 Apr 2003 23:37:38 +0200, Zoltan NAGY said:
> > On Mon, 21 Apr 2003, Greg KH wrote:
> > > What's the status of that patch being ported to the LSM interface (which
> > > is already in 2.5)?
> > 
> > AFAIK there was a discussion about it, but i dont know what decision has 
> > born.. 
> 
> Some parts of grsecurity were trivial to fit into the LSM framework.  Other
> parts are basically impossible simply because LSM doesn't hook into the
> code where it's needed....

Yes, hence the lack of motivation to bring over just the portable parts.
 
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
