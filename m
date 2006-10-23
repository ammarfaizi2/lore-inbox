Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWJWIX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWJWIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWJWIX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:23:27 -0400
Received: from adsl-ull-137-166.41-151.net24.it ([151.41.166.137]:19752 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1751811AbWJWIX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:23:27 -0400
Message-ID: <453C7B3B.1050601@abinetworks.biz>
Date: Mon, 23 Oct 2006 10:20:11 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.com
CC: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc2-mm2 ndiswrapper does not load
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since 2.6.19-mm2 ndiswrapper goes (dmesg):

__create_workqueue         undefined symbol
queue_work                       undefined symbol

And doesnt load.

Any idea ?

Gianluca
