Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVAJOJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVAJOJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVAJOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:09:42 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:34723 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262273AbVAJOJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:09:41 -0500
Date: Mon, 10 Jan 2005 15:09:37 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-bk12 - snd_ac97_resume oops
Message-ID: <20050110140937.GA20993@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with the latest bk snd_ac97_resume produces an oops. It's called from i810 sound
driver. Unfortunately oops will not stay in logs. But I can transcript if
necessary.

-- 
Luká¹ Hejtmánek
