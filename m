Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbQLTCWk>; Tue, 19 Dec 2000 21:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130864AbQLTCWb>; Tue, 19 Dec 2000 21:22:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5514 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130842AbQLTCWW>;
	Tue, 19 Dec 2000 21:22:22 -0500
Date: Tue, 19 Dec 2000 17:35:23 -0800
Message-Id: <200012200135.RAA08489@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: mhaque@haque.net
CC: kuznet@ms2.inr.ac.ru, tleete@mountain.net, laforge@gnumonks.org,
        rusty@linuxcare.com.au, netfilter-devel@us5.samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A400F2A.E5CD52BA@haque.net> (mhaque@haque.net)
Subject: Re: ip_defrag / ip_conntrack issues (was Re: [PATCH] Fix netfilter
In-Reply-To: <200012191454.RAA13529@ms2.inr.ac.ru> <3A400F2A.E5CD52BA@haque.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 19 Dec 2000 20:45:14 -0500
   From: "Mohammad A. Haque" <mhaque@haque.net>

   how is this meaningless?

   This just confirms what I and others have found in test12 wrt to the
   netfilter issue.

Alexey is talking about test12/netfilter + our ip_fragment.c fix,
not vanilla test12.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
