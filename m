Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRF2WAU>; Fri, 29 Jun 2001 18:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbRF2WAK>; Fri, 29 Jun 2001 18:00:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25511 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262436AbRF2V75>;
	Fri, 29 Jun 2001 17:59:57 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.64070.934822.960708@pizda.ninka.net>
Date: Fri, 29 Jun 2001 14:59:34 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dmitry Meshchaninov <dima@flash.datafoundation.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, cwl@iol.unh.edu,
        Denis Gerasimov <denis@datafoundation.com>
Subject: Re: qlogicfc driver
In-Reply-To: <3B3CF618.DDE40F17@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.30.0106291714470.11344-100000@flash.datafoundation.com>
	<3B3CF618.DDE40F17@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > If you are working on qlogicfc, that's great!
 > 
 > But since others are currently using this driver without problems, you
 > might consider sending in your patches separated out (per
 > Documentation/SubmittingPatches) so that it is easier for others to
 > review and apply them in turn.

One thing that is especially important is multi-platform testing
since the current driver does use all of the proper APIs and is
mindful of endianness and word size issues.

Later,
David S. Miller
davem@redhat.com
