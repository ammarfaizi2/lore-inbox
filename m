Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263298AbVCJWU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbVCJWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263278AbVCJWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:13:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:46546 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263259AbVCJWH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:07:56 -0500
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Omkhar Arasaratnam <iamroot@ca.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
In-Reply-To: <42307E4D.6080505@ca.ibm.com>
References: <422FA817.4060400@ca.ibm.com>
	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>
	 <422FC042.40303@ca.ibm.com>
	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
	 <1110434383.32525.184.camel@gaston>
	 <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>
	 <1110467868.5379.15.camel@mulgrave>  <42307E4D.6080505@ca.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 09:02:38 +1100
Message-Id: <1110492159.32524.261.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 11:05 -0600, Omkhar Arasaratnam wrote:

> 2.6.10 seems to have a different kernel panic which I'm investigating 
> (could be a problem with my ramdisk as it happens in my linuxrc). So 
> long story short the 2.6.10 sym driver looks ok.

Can you try 2.6.11 with the 2.6.10 sym driver ?

Ben.


