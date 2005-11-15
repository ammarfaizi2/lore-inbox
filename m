Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVKOSyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVKOSyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVKOSyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:54:04 -0500
Received: from [195.144.244.147] ([195.144.244.147]:29410 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S964975AbVKOSyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:54:03 -0500
Message-ID: <437A2EC7.2030503@varma-el.com>
Date: Tue, 15 Nov 2005 21:53:59 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
       ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert platform
 drivers to use_ (again)
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

I fear it is not a last patch of such kind :(.
Please recheck places where you are changed
pdev<->dev.

-- 
Regards
Andrey Volkov
