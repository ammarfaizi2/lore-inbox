Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277545AbRJESmz>; Fri, 5 Oct 2001 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277547AbRJESmf>; Fri, 5 Oct 2001 14:42:35 -0400
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:18048 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S277545AbRJESm0>; Fri, 5 Oct 2001 14:42:26 -0400
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.65326.541017.774801@cmb1-3.dial-up.arnes.si>
Date: Fri, 5 Oct 2001 20:42:54 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-ac4 (SMP, highmem) complete freeze
X-Mailer: VM 6.95 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same story as with 2.4.10, only faster:

After one day of uptime under load 2-3 (highmem),
the box froze completely. Only hard reboot (actually power unplug)
brought it back. Nothing in logs, nothing over netconsole-C2 ...

Hardware:
dual Xeon 550Mhz, C440GX+, 2GB RAM, 1GB swap, SCSI AIC-7896/7

-Igor Mozetic
