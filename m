Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSHPEtl>; Fri, 16 Aug 2002 00:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSHPEtl>; Fri, 16 Aug 2002 00:49:41 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:13701 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318155AbSHPEtk>; Fri, 16 Aug 2002 00:49:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>, Roger Luethi <rl@hellgate.ch>
Subject: Linksys Cards Suggestion
Date: Tue, 13 Aug 2002 09:02:23 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208130902.23258.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible to better document which Linksys cards are supported 
under the different types of Tulip drivers?

"Some LinkSys PCI cards are of this type"
is not very helpful from a user's point of view....

Also...my Linksys LNE100 TX
seems to work great with dc2114x tulip + new bus config + PCI shared mem 
on 2.5.31.

However, why is its name misdetected?
eth0: ADMtek Comet rev 17 at 0xd5009000, 00:04:5A:85:1F:C4, IRQ 11.


