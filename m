Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130435AbRCIGCu>; Fri, 9 Mar 2001 01:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbRCIGCk>; Fri, 9 Mar 2001 01:02:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130435AbRCIGCc>;
	Fri, 9 Mar 2001 01:02:32 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15016.29137.743441.608694@pizda.ninka.net>
Date: Thu, 8 Mar 2001 22:01:53 -0800 (PST)
To: gjohnson@research.canon.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resolving physical addresses
In-Reply-To: <20010309054528.16862.qmail@cass.research.canon.com.au>
In-Reply-To: <20010309054528.16862.qmail@cass.research.canon.com.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.x pte_page() gives a pointer to a page struct, not an address
as in 2.2.x.

Later,
David S. Miller
davem@redhat.com
