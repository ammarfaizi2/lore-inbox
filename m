Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbRGQWWc>; Tue, 17 Jul 2001 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbRGQWWW>; Tue, 17 Jul 2001 18:22:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267484AbRGQWWO>;
	Tue, 17 Jul 2001 18:22:14 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15188.47766.969058.163622@pizda.ninka.net>
Date: Tue, 17 Jul 2001 15:22:14 -0700 (PDT)
To: Terence Haddock <thaddock@tripi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP connections hang with TCP_RETRANS_COLLAPSE=1 - kernel bug?
In-Reply-To: <20010717164928.A2457@haddock.fhint.com>
In-Reply-To: <20010717164928.A2457@haddock.fhint.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Terence Haddock writes:
 > I am having TCP/IP connections "hang", and investigation seems to point to
 > the tcp_retrans_collapse feature as the culprit. I have the following
 > network configuration:

Known checksum computation bug, fixed in current 2.4.7-preX kernels.

Later,
David S. Miller
davem@redhat.com
