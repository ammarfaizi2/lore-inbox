Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUIGT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUIGT1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268503AbUIGTWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:22:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:16306 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268504AbUIGTST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:18:19 -0400
Date: Tue, 7 Sep 2004 12:14:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: alan@lxorguk.ukuu.org.uk, hch@lst.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark install_page static
Message-Id: <20040907121443.68c5c3b8.rddunlap@osdl.org>
In-Reply-To: <20040907181259.GA12654@lst.de>
References: <20040907143741.GA8606@lst.de>
	<1094576968.9599.9.camel@localhost.localdomain>
	<20040907181259.GA12654@lst.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 20:12:59 +0200 Christoph Hellwig wrote:

| On Tue, Sep 07, 2004 at 06:09:29PM +0100, Alan Cox wrote:
| > On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
| > > Not used anywhere in modules and it really shouldn't either.
| > 
| > Doesn't that happen (conveniently from some viewpoints Im sure) to break
| > vmware ?
| 
| It happens because Arjan & I wrote up some scripts to find dead exports.

Can you put those at kernelnewbies.org or janitor.kernelnewbies.org ?

--
~Randy
