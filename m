Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUHDNjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUHDNjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUHDNjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:39:25 -0400
Received: from palrel13.hp.com ([156.153.255.238]:36243 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265654AbUHDNjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:39:21 -0400
From: "Sourav Sen" <souravs@india.hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: CONFIG_FORCE_MAX_ZONEORDER
Date: Wed, 4 Aug 2004 19:09:17 +0530
Message-ID: <012401c47a28$70fb62a0$39624c0f@asiapacific.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a way of changing the value of MAX_ORDER
using CONFIG_FORCE_MAX_ZOMEORDER? During 'make xconfig'
I did not see a way. If I change it by hand in .config
and then run make oldconfig, it gets changed back to
the old value (== 18). The source version is 2.6.6

And, if it matters here -- I am on ia64. 

Thanks
Sourav
