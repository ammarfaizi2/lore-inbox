Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWGaTYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWGaTYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbWGaTYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:24:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030341AbWGaTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:24:06 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Clay Barnes <clay.barnes@gmail.com>
Cc: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
	 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>
	 <20060731144736.GA1389@merlin.emma.line.org>
	 <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <20060731162224.GJ31121@lug-owl.de>
	 <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
	 <20060731173239.GO31121@lug-owl.de>
	 <20060731181120.GA9667@merlin.emma.line.org>
	 <20060731184314.GQ31121@lug-owl.de>
	 <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 20:42:02 +0100
Message-Id: <1154374923.7230.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 12:17 -0700, ysgrifennodd Clay Barnes:
> Of course, if ext3 were proven to be more robust against failures, I bet
> the reiser team would be very interested in all the forensic data you
> can offer, since, from what I've seen, they are always trying to make
> reiser as good as possible---in speed, flexability, *and* robustness.

Its well accepted that reiserfs3 has some robustness problems in the
face of physical media errors. The structure of the file system and the
tree basis make it very hard to avoid such problems. XFS appears to have
managed to achieve both robustness and better data structures. 

How reiser4 compares I've no idea. 

Alan

