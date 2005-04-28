Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVD1QCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVD1QCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVD1QCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:02:18 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33313 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262109AbVD1QCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:02:03 -0400
Subject: Extremely poor umass transfer rates
From: Mark Rosenstand <mark@ossholes.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 28 Apr 2005 18:02:22 +0200
Message-Id: <1114704142.8410.4.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get transfer rates at around 30 kB/s to USB mass storage devices. It
applies to both my keyring and my mp3 player. Both are running vfat.

I'm running 2.6.12-rc3 for amd64 with patches for inotify and skge. The
motherboard is an ASUS K8V-X (VIA K8T800).

It worked alright earlier (2.6.10 or 2.6.11, I'll test later if
necessary.)

Also, if I transfer more than one file at a time the music tracks start
overlapping on my mp3 player.

Any hints?

-- 
  .-.    Mark Rosenstand        (-.)
  oo|                           cc )
 /`'\    (+45) 255 31337      3-n-(
(\_;/)   mark@geekworld.org    _(|/`->

