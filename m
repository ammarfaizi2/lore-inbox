Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264491AbRFTCw5>; Tue, 19 Jun 2001 22:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264494AbRFTCws>; Tue, 19 Jun 2001 22:52:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37250 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264491AbRFTCw2>;
	Tue, 19 Jun 2001 22:52:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.4073.812901.656882@pizda.ninka.net>
Date: Tue, 19 Jun 2001 19:52:25 -0700 (PDT)
To: "Zack Weinberg" <zackw@Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, tridge@samba.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
In-Reply-To: <20010619194827.F5679@stanford.edu>
In-Reply-To: <15152.1911.886630.381952@pizda.ninka.net>
	<20010619194827.F5679@stanford.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zack Weinberg writes:
 > It *has* been fixed in 2.4, though.  Some sort of compatibility issue?

No, some kind of "it doesn't matter" issue.

Later,
David S. Miller
davem@redhat.com
