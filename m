Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbTAAXRo>; Wed, 1 Jan 2003 18:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbTAAXRn>; Wed, 1 Jan 2003 18:17:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51384 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265187AbTAAXRn>;
	Wed, 1 Jan 2003 18:17:43 -0500
Date: Wed, 01 Jan 2003 15:18:43 -0800 (PST)
Message-Id: <20030101.151843.71131792.davem@redhat.com>
To: szepe@pinerecords.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] move CONFIG_NET to net/Kconfig
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030101215541.GF17053@louise.pinerecords.com>
References: <20030101204325.GB17053@louise.pinerecords.com>
	<Pine.LNX.4.44.0301011345100.12809-100000@home.transmeta.com>
	<20030101215541.GF17053@louise.pinerecords.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Wed, 1 Jan 2003 22:55:41 +0100

   > I really think that's the only reasonable option. Please talk to Davem 
   > about getting the resuling sparc problems fixed up (it probably entails 
   > making sure that all the network drivers have the proper dependencies on 
   > PCI and ISA etc).
   
   Yes, I'm working on that at the moment.  Pete Zaitcev likes the idea and
   DaveM won't probably hate it either, as that's how sparc64 has always been.

Right, I'm fine with it.
