Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUCLXPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUCLXPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:15:30 -0500
Received: from ep09.kernel.pl ([212.87.11.162]:14781 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id S263018AbUCLXP3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:15:29 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: snd-powermac volume setting broken?
Date: Sat, 13 Mar 2004 00:15:17 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403130015.17674.adasi@kernel.pl>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I use alsa snd-powermac driver, the lowest volume setting (but without 
muting) is at about half of full volume, it's impossible to get any volume 
level between mute and vol=0. Is that a bug or a feature?
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net

