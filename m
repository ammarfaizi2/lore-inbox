Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTB0LeR>; Thu, 27 Feb 2003 06:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTB0LeR>; Thu, 27 Feb 2003 06:34:17 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:6085 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264705AbTB0LeQ>;
	Thu, 27 Feb 2003 06:34:16 -0500
Date: Thu, 27 Feb 2003 12:44:17 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: [0/2][via-rhine][ANNOUNCE] 1.17rc
Message-ID: <20030227114417.GA3970@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two more patches for the via-rhine driver. Please apply.

With these patches, the Rhine-II passes stress testing for the first time.
There are still a few issues, but the driver doesn't break down under load
like all previous ones did.

Roger
