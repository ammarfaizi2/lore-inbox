Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287701AbSAABE1>; Mon, 31 Dec 2001 20:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287708AbSAABET>; Mon, 31 Dec 2001 20:04:19 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:8209 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287701AbSAABEB>; Mon, 31 Dec 2001 20:04:01 -0500
Subject: Re: 2.4.18-pre1 -- fs/partitions/ibm.c doesn't compile.
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>,
        Holger Smolinski <Holger.Smolinski@de.ibm.com>,
        Volker Sameske <sameske@de.ibm.com>, Linux390@de.ibm.com
In-Reply-To: <1009845099.1407.623.camel@stomata.megapathdsl.net>
In-Reply-To: <1009845099.1407.623.camel@stomata.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.29.08.57 (Preview Release)
Date: 31 Dec 2001 17:04:44 -0800
Message-Id: <1009847085.1407.691.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.  My apologies.  I was testing CML2 when I encountered this
problem.  When I removed CML2 and ran make oldconfig, I didn't
see IBM Partition offered as a configuration option.  So, I expect
that this is a CML2 problem.

I'll follow up with Eric S. Raymond.

	Miles

