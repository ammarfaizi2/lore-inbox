Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267811AbRGRDEW>; Tue, 17 Jul 2001 23:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267812AbRGRDEM>; Tue, 17 Jul 2001 23:04:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29312 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267811AbRGRDD5>;
	Tue, 17 Jul 2001 23:03:57 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15188.64670.961076.478032@pizda.ninka.net>
Date: Tue, 17 Jul 2001 20:03:58 -0700 (PDT)
To: Alexander Viro <viro@math.psu.edu>
Cc: dpicard@rcn.com, Aaron Sethman <androsyn@ratbox.org>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <Pine.GSO.4.21.0107172246050.1861-100000@weyl.math.psu.edu>
In-Reply-To: <3B54F11A.DD2767E8@psind.com>
	<Pine.GSO.4.21.0107172246050.1861-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexander Viro writes:
 > Stack on Sparc grows up.

nope, grows down on both platforms

The HPPA/Linux folks wouldn't have had so many problems if Sparc's
stack grew up rather than down :-)

Later,
David S. Miller
davem@redhat.com
