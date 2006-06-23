Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWFWMnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWFWMnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWFWMnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:43:32 -0400
Received: from [203.134.223.74] ([203.134.223.74]:40124 "EHLO cybernetra.net")
	by vger.kernel.org with ESMTP id S964785AbWFWMnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:43:31 -0400
From: Gurvinder Singh <gurvinder@cybernetra.net>
Organization: Cybernetra
To: lkml <linux-kernel@vger.kernel.org>
Subject: where ipsec lies in kernel
Date: Fri, 23 Jun 2006 18:18:31 +0530
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231818.31824.gurvinder@cybernetra.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi 
i am implementing openswan based on ipsec in linux kernel 2.6.16.16 with the 
use of ipsec stack in linux kernel . i want to know where ipsec stack lies in 
the kernel and how it handle the vpn requests. i am having 2 nic in my pc 
eth0 and eth1 , eth0 is connected to the internet on which i am running 
ipsec . i want to know whenever i send any packet to the vpn connection at 
what stage it get encrypted , i need internals of  kernel ipsec stack 
working .
can anyone help me.......................



Gurvinder Singh
