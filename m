Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUB2ALO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 19:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbUB2ALO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 19:11:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:42941 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261952AbUB2ALL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 19:11:11 -0500
Subject: Re: [patch] new version, u64 cast avoidance
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1077979564.2233.70.camel@cube>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
	 <1077979564.2233.70.camel@cube>
Content-Type: text/plain
Message-Id: <1078012722.905.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 29 Feb 2004 10:58:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  asm-ppc64/types.h   |   14 ++++++++++++--

Please, do not mess with ppc64 at this point, I'm not sure
I like the approach anyway, I can live with some warnings
in printk...

Ben.


