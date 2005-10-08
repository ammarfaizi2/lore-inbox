Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVJHQpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVJHQpY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 12:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVJHQpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 12:45:24 -0400
Received: from smtp05.web.de ([217.72.192.209]:7560 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S932147AbVJHQpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 12:45:23 -0400
Message-ID: <4347F78E.2050109@web.de>
Date: Sat, 08 Oct 2005 18:45:02 +0200
From: Enrico Bartky <DOSProfi@web.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SiS96x SMBus
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the quirks for enabling the SiS96x SMBus doesn't work for the x86_64. 
For the i386 architecture it works. I thought the pci/quirks.c is 
architecture independ!? Can anyone fix it?

Thanx
EnricoB
