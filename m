Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136432AbRD3CBB>; Sun, 29 Apr 2001 22:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136433AbRD3CAu>; Sun, 29 Apr 2001 22:00:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60306 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136432AbRD3CAr>;
	Sun, 29 Apr 2001 22:00:47 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15084.51009.307680.762314@pizda.ninka.net>
Date: Sun, 29 Apr 2001 19:00:33 -0700 (PDT)
To: Frank de Lange <frank@unternet.org>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
In-Reply-To: <20010430022455.A17694@unternet.org>
In-Reply-To: <20010429181809.A10479@unternet.org>
	<200104291911.XAA04489@ms2.inr.ac.ru>
	<20010429214853.G11681@unternet.org>
	<15084.42876.515254.47471@pizda.ninka.net>
	<20010430022455.A17694@unternet.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank de Lange writes:
 > Hm, 'twould be nice to know WHAT to look for (if only for educational
 > purposes), but ok:

We're looking to see if queue collapsing is occuring on
receive.

Later,
David S. Miller
davem@redhat.com
