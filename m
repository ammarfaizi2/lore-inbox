Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUARSfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUARSfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:35:41 -0500
Received: from mail.convergence.de ([212.84.236.4]:44012 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262794AbUARSfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:35:36 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 0/5] LinuxTV.org DVB update
In-Reply-To: 
Message-Id: <10744509222284@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Sun, 18 Jan 2004 13:35:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Andrew,

I'm about to send you a set of 5 patches that sync the
LinuxTV.org CVS with latest linux-2.6.1/linux-2.6.1-mm4.

As usual, detailed informations about what changed can be 
found at the top of each file.

The patch "04-DVB-av7110-driver-splitup.diff" is bzip2'ed,
because it removes the av7110 DVB driver source and replaces
it with a modularized version. Sorry for the inconvenience!

Please apply! 

CU
Michael.


