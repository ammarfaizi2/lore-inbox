Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVIRU5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVIRU5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVIRU5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:57:46 -0400
Received: from talin.podgorze.pl ([195.225.250.33]:5304 "EHLO
	thinkpaddie.zlew.org") by vger.kernel.org with ESMTP
	id S932197AbVIRU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:57:46 -0400
From: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Organization: KDE
To: linux-kernel@vger.kernel.org
Subject: dell's latitude cdburner problem
Date: Sun, 18 Sep 2005 22:57:21 +0200
User-Agent: KMail/1.8.91
X-Face: ?m}EMc-C]"l7<^`)a1NYO-('xy3:5V{82Z^-/D3^[MU8IHkf$o`~%CC5D4[GhaIgk/$oN7
	Y7;f}!(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>~1Nt2fh
	s-iKbN$.Ne^1(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,dn-
	Kh{hA{~Ls4a$NjJI@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509182257.23363@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I don't know whether this is linuxes cdrecord issue, or kernel issue.
I have dell latitude c640 laptop with their's dvd/cd-rw combo drive that 
appears as:
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache

Trouble is, that this drive suppose to write CDs at 24x, and does so under 
windows. But under Linux it works only 8x. Anyone with the same problem 
please?

-- 
GJ

Binary system, you're either 1 or 0...
dead or alive ;)
