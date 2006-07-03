Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWGCJma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWGCJma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWGCJma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:42:30 -0400
Received: from hobbit.neveragain.de ([217.69.77.34]:40951 "EHLO
	hobbit.neveragain.de") by vger.kernel.org with ESMTP
	id S1751030AbWGCJm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:42:29 -0400
Date: Mon, 3 Jul 2006 11:43:15 +0200
From: Carsten Otto <cotto@hobbit.neveragain.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm5 crashes with AHCI error (libata)
Message-ID: <20060703094315.GA36774@hobbit.neveragain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (hobbit.neveragain.de [127.0.0.1]); Mon, 03 Jul 2006 11:43:15 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Please note my other current problem, because it might be related to
this. The thread has the title "Huge problem with XFS/iCH7R".

I tried booting 2.6.17-mm5, but got the following error message:
http://c-otto.de/fehler/SANY1138.JPG

With 2.6.17.2 I can boot, but have following problems:
- directly before the booting process I did xfs_repair with the latest
  version (2.8.something) of xfs_repair
- one _very_ huge (and important) directory disappeared
- the dirs in /lost+found2 (manually renamed from lost+found) can still
  not be deleted (seee previous thread)

You can find my detailled system specs in my previous thread.

Thanks for any help,
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
