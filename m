Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263111AbTCTX7m>; Thu, 20 Mar 2003 18:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCTX7m>; Thu, 20 Mar 2003 18:59:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49843 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263025AbTCTX7k>;
	Thu, 20 Mar 2003 18:59:40 -0500
Date: Thu, 20 Mar 2003 16:08:45 -0800 (PST)
Message-Id: <20030320.160845.121240938.davem@redhat.com>
To: fubar@us.ibm.com
Cc: hshmulik@intel.com, bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [Bonding-devel] [patch] (2/8) Add 802.3ad support to bonding
 (released to bonding on sourceforge)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF102C4F31.A103F2FF-ON88256CEF.007C2E59@us.ibm.com>
References: <OF102C4F31.A103F2FF-ON88256CEF.007C2E59@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jay Vosburgh <fubar@us.ibm.com>
   Date: Thu, 20 Mar 2003 14:53:14 -0800
   
         I have incorporated Shmulik Hen's bug fix patches to bonding (patch
   numbers 2 and 3) into the current code and released the new patch to
   sourceforge.net/projects/bonding.  The current bonding update is
   bonding-2.4.20-20030320.  The only changes I made were minor spelling /
   formatting fixes.

So when do these changes end up being sent to myself or
Jeff for mainline inclusion?

I have no objection to the sourceforge project for bonding, but
I do object to there being such latency between what the sourceforge
tree has (especially bug fixes) and what gets submitted into the
mainline.

Personally, I'd prefer that all development occur in the mainline
tree.  That gives you testing coverage that is impossible otherwise.
