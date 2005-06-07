Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVFGSMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVFGSMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFGSMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:12:55 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:23570 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261932AbVFGSMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:12:54 -0400
Date: Tue, 7 Jun 2005 20:13:00 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050607181300.GL2369@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

should chelsio 10GE driver work in this kernel? If I do modprobe cxgb, then it
silently returns. No messages in log (dmesg) nor terminal and no new ethX 
device is discoverred.

-- 
Luká¹ Hejtmánek
