Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRB0AaO>; Mon, 26 Feb 2001 19:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRB0A35>; Mon, 26 Feb 2001 19:29:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59807 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129318AbRB0A3v>;
	Mon, 26 Feb 2001 19:29:51 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.62538.794351.930198@pizda.ninka.net>
Date: Mon, 26 Feb 2001 16:26:50 -0800 (PST)
To: Simon Kirby <sim@netnation.com>
Cc: Jordan Mendelson <jordy@napster.com>, ookhoi@dds.nl,
        Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
In-Reply-To: <20010226162107.A31575@netnation.com>
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc>
	<20010221104723.C1714@humilis>
	<14995.40701.818777.181432@pizda.ninka.net>
	<3A9453F4.993A9A74@napster.com>
	<14996.21701.542448.49413@pizda.ninka.net>
	<20010226162107.A31575@netnation.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simon Kirby writes:
 > Has such a patch gone in to the kernel yet?

Yep, it is in both the zerocopy and AC patches. (Linus is
away at the moment)

Later,
David S. Miller
davem@redhat.com
