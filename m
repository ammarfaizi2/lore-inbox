Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSK0MNd>; Wed, 27 Nov 2002 07:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSK0MNc>; Wed, 27 Nov 2002 07:13:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58516 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262414AbSK0MM0>; Wed, 27 Nov 2002 07:12:26 -0500
Subject: Re: [PATCH] Start of compat32.h (again)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: davidm@hpl.hp.com, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
In-Reply-To: <20021127082918.GA5227@averell>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<15844.31669.896101.983575@napali.hpl.hp.com> 
	<20021127082918.GA5227@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 12:49:10 +0000
Message-Id: <1038401350.6390.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 08:29, Andi Kleen wrote:
> But the 32bit user space surely doesn't care about any garbage in 
> the upper 32bits, no ?

Providing its garbage not leaked kernel data

