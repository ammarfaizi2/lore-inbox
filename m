Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUHXQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUHXQmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUHXQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:42:08 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:13456 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S268090AbUHXQmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:42:06 -0400
Message-ID: <412B6FD6.2050105@drzeus.cx>
Date: Tue, 24 Aug 2004 18:41:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC patches included in 2.6.9-rc1 missed drivers/Kconfig. A 'source 
"drivers/mmc/Kconfig"' is needed.
drivers/Makefile is ok though.

Rgds
Pierre Ossman
