Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSBLPvb>; Tue, 12 Feb 2002 10:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLPvL>; Tue, 12 Feb 2002 10:51:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13188 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288511AbSBLPvD>;
	Tue, 12 Feb 2002 10:51:03 -0500
Date: Tue, 12 Feb 2002 07:49:05 -0800 (PST)
Message-Id: <20020212.074905.18307508.davem@redhat.com>
To: stodden@in.tum.de
Cc: groudier@free.fr, alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: pci_pool reap?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1013528224.2240.245.camel@bitch>
In-Reply-To: <20020210211352.Q1910-100000@gerard>
	<20020211.184412.35663889.davem@redhat.com>
	<1013528224.2240.245.camel@bitch>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Stodden <stodden@in.tum.de>
   Date: 12 Feb 2002 16:36:34 +0100

   back to my original question: what were the last trees with shrinking
   pools? would the original version still work or any redesigns needed?

Probably yes and it was the first 2.4.x that the pci_pool stuff
appeared in.  Peter Zaitcev disabled the shrinking in the next
release I believe, or soon thereafter.
