Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFFNOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFFNOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFFNOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:14:19 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:57350 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261378AbVFFNOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:14:17 -0400
Date: Mon, 6 Jun 2005 15:14:25 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Sk98Lin driver
Message-ID: <20050606131425.GF18862@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

does someone have some experiences with this card? I'm using 8.16 or 8.18 driver
(I do not want 6.x driver as it does not support suspend/resume).
Basically it works but on UDP I get about 50 % packet loss when I try to receive
1Gbps. It's reported as frame and overruns.

Does someone have similar observation?

-- 
Luká¹ Hejtmánek
