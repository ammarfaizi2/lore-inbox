Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272191AbRI0JLe>; Thu, 27 Sep 2001 05:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRI0JLY>; Thu, 27 Sep 2001 05:11:24 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:13327 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S272191AbRI0JLI>;
	Thu, 27 Sep 2001 05:11:08 -0400
Date: Thu, 27 Sep 2001 11:10:06 +0200
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 2.4.10 (SMP, highmem) solid freeze
To: linux-kernel@vger.kernel.org
Message-id: <15282.60654.52083.446184@proizd.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.95 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After two days of uptime under load 2-3 (no swapping, not much I/O),
the box froze completely. Only hard reboot brought it back.
Nothing in logs, sorry ...
Hardware seems OK, other machines (UP, no highmem) run fine so far.

Hardware:
dual Xeon 550Mhz, C440GX+, 2GB RAM, 1GB swap, SCSI AIC-7896/7

-Igor Mozetic
