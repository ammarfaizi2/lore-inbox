Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRFSVQA>; Tue, 19 Jun 2001 17:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264802AbRFSVPu>; Tue, 19 Jun 2001 17:15:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264801AbRFSVPq>;
	Tue, 19 Jun 2001 17:15:46 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15151.49403.344626.759512@pizda.ninka.net>
Date: Tue, 19 Jun 2001 14:15:39 -0700 (PDT)
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <p0510030ab7556d686012@[10.128.7.49]>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca>
	<3B2F769C.DCDB790E@kegel.com>
	<20010619090956.R3089@work.bitmover.com>
	<p05100302b7553d481172@[10.128.7.49]>
	<15151.48287.782428.953466@pizda.ninka.net>
	<p0510030ab7556d686012@[10.128.7.49]>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Lundell writes:
 > It seems to me that the telling argument against threads has much 
 > more to do with the potential complexity of the resulting code than 
 > with after-all-minor performance considerations.

I don't get this impression, see the stack space memory usage parts
of this thread, particular some of Larry's postings.

Later,
David S. Miller
davem@redhat.com
