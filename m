Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTDUVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTDUVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:31:16 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:28917 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262609AbTDUVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:31:13 -0400
Date: Mon, 21 Apr 2003 14:38:49 -0700
From: Chris Wright <chris@wirex.com>
To: Zoltan NAGY <nagyz@piarista-kkt.sulinet.hu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: grsecurity in 2.5?
Message-ID: <20030421143849.A11883@figure1.int.wirex.com>
Mail-Followup-To: Zoltan NAGY <nagyz@piarista-kkt.sulinet.hu>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030421212501.GA30266@kroah.com> <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu>; from nagyz@piarista-kkt.sulinet.hu on Mon, Apr 21, 2003 at 11:37:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zoltan NAGY (nagyz@piarista-kkt.sulinet.hu) wrote:
> On Mon, 21 Apr 2003, Greg KH wrote:
> 
> > What's the status of that patch being ported to the LSM interface (which
> > is already in 2.5)?
> 
> AFAIK there was a discussion about it, but i dont know what decision has 
> born.. 

I don't think the grsecurity developers are motivated to port their work
to LSM.  Patches are welcome of course ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
