Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVCOXol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVCOXol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVCOXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:42:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:57770 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262126AbVCOXkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:40:55 -0500
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Omkhar Arasaratnam <iamroot@ca.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
In-Reply-To: <4237051E.6080107@ca.ibm.com>
References: <422FA817.4060400@ca.ibm.com>
	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>
	 <422FC042.40303@ca.ibm.com>
	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
	 <1110434383.32525.184.camel@gaston>
	 <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>
	 <1110467868.5379.15.camel@mulgrave>  <42307E4D.6080505@ca.ibm.com>
	 <1110492159.32524.261.camel@gaston>  <4237051E.6080107@ca.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 10:38:40 +1100
Message-Id: <1110929920.24296.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 09:54 -0600, Omkhar Arasaratnam wrote:
> Benjamin Herrenschmidt wrote:

> The 2.6.11.3 kernel with the 2.6.10 driver seems to fail with the same 
> sym2 driver error - so I suppose it goes deeper than the driver itself.
> 

Let's move that to linuxppc64-dev and drop the CC-list. Last message on
this thread.

Ben.


