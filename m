Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWEOVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWEOVPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWEOVPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:15:19 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:54438 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965232AbWEOVPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:15:18 -0400
Message-Id: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:29 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 00/11] input: force feedback updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Major update for the force feedback support, including a new force feedback
driver interface and two new HID ff drivers. 

--
Anssi Hannula
