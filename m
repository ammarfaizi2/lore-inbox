Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUGRL5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUGRL5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGRL5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:57:30 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:17325 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263806AbUGRL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:57:29 -0400
Message-ID: <40FA659B.2060302@t-online.de>
Date: Sun, 18 Jul 2004 13:57:15 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040717
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2: kernel panic with CONFIG_ACPI_DEBUG=y
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Ew7ORgZeZeQsCKbS-cd3OfBrvFpphMfIRr2btbqi02glxrBCEV5oUd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

If I set CONFIG_ACPI_DEBUG=y, then there is a panic at
boot time:

/sbin/init: 424: cannot open dev/console: No such file
Kernel panic: Attempted to kill init!


Regards

Harri
