Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTAITy7>; Thu, 9 Jan 2003 14:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267767AbTAITy7>; Thu, 9 Jan 2003 14:54:59 -0500
Received: from main.gmane.org ([80.91.224.249]:55206 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267758AbTAITy7>;
	Thu, 9 Jan 2003 14:54:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason Lunz <lunz@falooley.org>
Subject: detecting hyperthreading in linux 2.4.19
Date: Thu, 9 Jan 2003 20:02:33 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnb1rlct.g2c.lunz@stoli.localnet>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way for a userspace program running on linux 2.4.19 to tell
the difference between a single hyperthreaded xeon P4 with HT enabled
and a dual hyperthreaded xeon P4 with HT disabled? The /proc/cpuinfos
for the two cases are indistinguishable.

Jason

