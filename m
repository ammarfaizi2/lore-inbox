Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbRBAL23>; Thu, 1 Feb 2001 06:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129080AbRBAL2S>; Thu, 1 Feb 2001 06:28:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23449 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129063AbRBAL2C>;
	Thu, 1 Feb 2001 06:28:02 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.18371.677242.728885@pizda.ninka.net>
Date: Thu, 1 Feb 2001 03:25:55 -0800 (PST)
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
In-Reply-To: <20010201112014.A27009@sable.ox.ac.uk>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
	<20010131152653.C13345@sable.ox.ac.uk>
	<14968.49462.674977.825098@pizda.ninka.net>
	<20010201112014.A27009@sable.ox.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Malcolm Beattie writes:
 > Alexey has mailed me suggesting the problem may be that netfilter
 > is turned on.

Oh yes, netfilter being enabled will cause some performance
degradation, that is for sure.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
