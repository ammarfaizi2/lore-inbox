Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTEaHwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTEaHwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:52:25 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:48783 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S264201AbTEaHwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:52:25 -0400
Date: Sat, 31 May 2003 10:05:45 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.70 freezes when running hwclock
Message-ID: <20030531080544.GA13848@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried 2.5.70 on an intel chipset based pc, and I got a
reproductible complete freeze during the boot process when hwclock is
run. Even Caps Lock wouldn't lit the little led.

Removing the offending line, 2.5.70 seemed to work... I haven't fully
tried it yet.

Is this problem known/identified/fixed yet, or do you want a more
complete bug report ?

Regards,

	Éric Brunet	
