Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUILQMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUILQMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUILQMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:12:07 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:58289 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268367AbUILQLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:11:23 -0400
Date: Sun, 12 Sep 2004 18:11:19 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4 - slowdown?
Message-ID: <20040912161119.GR2260@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have fish-fillets game ported to linux. Under 2.6.9-rc1-bk9 it eats up to 10%
with normal speed of game and up to 40% with fast mode.
Under 2.6.9-rc1-mm4 it eats up to 40% with normal speed of game and cpu is too
slow for fast mode.

Any ideas?

For both kernels I use almost the same .config.

-- 
Luká¹ Hejtmánek
