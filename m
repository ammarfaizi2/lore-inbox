Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUARGEH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 01:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUARGEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 01:04:07 -0500
Received: from pool-64-223-239-211.port.east.verizon.net ([64.223.239.211]:60383
	"EHLO evilbint.mylan") by vger.kernel.org with ESMTP
	id S266239AbUARGEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 01:04:05 -0500
Date: Sun, 18 Jan 2004 01:04:04 -0500
From: Greg Fitzgerald <gregf@bigtimegeeks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Slowwwwwwwwwwww NFS read performance....
Message-ID: <20040118060404.GA20769@evilbint>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <200401130155.32894.hackeron@dsl.pipex.com> <1074025508.1987.10.camel@lumiere> <1074026758.4524.65.camel@nidelv.trondhjem.org> <bu4pd6$anf$1@news.cistron.nl> <1074134135.1522.52.camel@nidelv.trondhjem.org> <1074193256.2148.55.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074193256.2148.55.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since i upgraded to 2.6 my NFS performance has dropped.
I have a OpenBSD Server running nfsd. The other boxes on my lan
running windows and or the 2.4.x kernel have no performance problems.
Files transfer at normal speeds for a 100mbit connection. My main workstation
which is running 2.6.1-mm4 (i have also had 2.6.1 and 2.6.0 on it) has 
almost zero nfs performance. I get at the most 500K/s. Anyone have ideas?
I upgraded to -mm4 having seen some NFS fixes in the patch but none of them
seem to have applied to my situation. Thanks in advance.

--Greg
