Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTBOLHg>; Sat, 15 Feb 2003 06:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTBOLHg>; Sat, 15 Feb 2003 06:07:36 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:49843 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261426AbTBOLHe>;
	Sat, 15 Feb 2003 06:07:34 -0500
Date: Sat, 15 Feb 2003 12:17:05 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [0/4][via-rhine] Improvements
Message-ID: <20030215111705.GA11127@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here comes a batch of patches for the via-rhine driver. Please apply.

via-rhine is still hardly usable on the most common Rhine hardware; it
can't sustain 100Mbps traffic. The changes presented here improve the
situation considerably; they fix a number of real problems and have been
tested for regression (alas, by few people).

Roger
