Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUHMLBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUHMLBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHMLBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:01:53 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:48856 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261232AbUHMLBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:01:49 -0400
Message-ID: <2a4f155d0408130401112dad3a@mail.gmail.com>
Date: Fri, 13 Aug 2004 14:01:43 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Two problems with 2.6.8-rc4-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having some problems with 2.6.8-rc4-mm1

1- In syslog I am getting messages like :

Probing IDE interface ide0...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !

2- Penguin logo doesn't show up in console though framebuffer is enabled.

Any ideas?

/ismail

-- 
Time is what you make of it
