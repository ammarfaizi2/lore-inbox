Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136757AbREAXJP>; Tue, 1 May 2001 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136758AbREAXJE>; Tue, 1 May 2001 19:09:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34700 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136757AbREAXIt>;
	Tue, 1 May 2001 19:08:49 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.16863.150142.252108@pizda.ninka.net>
Date: Tue, 1 May 2001 16:08:15 -0700 (PDT)
To: kuznet@ms2.inr.ac.ru
Cc: andrea@suse.de (Andrea Arcangeli), ralf@nyren.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
In-Reply-To: <200105011810.WAA00750@ms2.inr.ac.ru>
In-Reply-To: <20010501193225.D31373@athlon.random>
	<200105011810.WAA00750@ms2.inr.ac.ru>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:
 > > See?
 > 
 > I see! Dave, please, take the second Andrea's patch (appended).
 > It is really the cleanest one.

Thanks a lot Andrea and Alexey.  I've applied the patch.

Later,
David S. Miller
davem@redhat.com
