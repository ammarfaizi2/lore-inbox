Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbTFAPcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTFAPcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:32:43 -0400
Received: from [62.39.112.246] ([62.39.112.246]:35494 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S264649AbTFAPcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:32:42 -0400
Date: Sun, 1 Jun 2003 17:46:00 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 and 2.5.70-mm3 hang on bootup
Message-ID: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both 2.5.70 and 2.5.70-mm3 hang right after "Ok, booting the kernel..." on 
one of my test boxes (at the point, nothing works, not even turning on/off 
the NumLock LED).

Hardware: ASUS A7S333, Athlon 2600+, 1 GB RAM
Compiler: gcc 3.3

Haven't had the time to debug this yet (and probably won't have the time 
for a couple more days, busy with work ATM); any ideas?

LLaP
bero
