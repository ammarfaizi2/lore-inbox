Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269448AbUIZAZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269448AbUIZAZz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUIZAZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:25:53 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:36317 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S269448AbUIZAX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:23:26 -0400
Date: Sun, 26 Sep 2004 02:23:23 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2 - p4mod_clock + suspend troubles
Message-ID: <20040926002322.GA1655221@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2i
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after suspend p4mod_clock is unable to change CPU speed anymore and moreover
/proc/cpuinfo shows 2400MHz but system runs about 1200MHz only. Reboot helps.

-- 
Luká¹ Hejtmánek
