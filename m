Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUFPR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUFPR7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUFPR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:59:34 -0400
Received: from mail.ycom.ch ([145.232.227.155]:5382 "EHLO ycom.ch")
	by vger.kernel.org with ESMTP id S264355AbUFPR4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:56:41 -0400
Subject: forcedeth - vlan - 2.6.7
From: Alexandre Ghisoli <alexandre.ghisoli@ycom.ch>
To: linux-kernel@vger.kernel.org
Cc: c-d.hailfinger.kernel.2004@gmx.net
Content-Type: text/plain
Organization: YCOM SA
Message-Id: <1087408598.7898.22.camel@pc-04.ycom.ch>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 16 Jun 2004 19:56:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, 

I've a 2.6.7 kernel, and I cannot use VLAN (MTU problem)

HW : ASUS A7N266VM-AA, onboard lan

When I do a ping (from another host to my box) -s 1468, it's working,
but not at 1470.
So, I've commented out #if 1 for debug, and there is no logging output
(rx_process) for thoses big packets (and, of course, tcpdump cannot see
it). Dropped by the nic ?

Could you help me ?

Thanks

Best regards

	--Alexandre

