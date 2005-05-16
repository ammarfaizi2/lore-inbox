Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVEPQEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEPQEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEPQEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:04:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2437 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261720AbVEPQEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:04:12 -0400
Date: Mon, 16 May 2005 18:04:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RR for route
Message-ID: <Pine.LNX.4.61.0505161803180.26484@yvahk01.tjqt.qr>
X-Copyright: "Copyright (C) by Jan Engelhardt. All Rights Reserved."
X-Notice: "Duplication, redistribution and involvement of third parties is not permitted without prior written permission."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


does anybody know of a way to round-robin over multiple default gateways with 
the same metric? Currently, it looks like it's always the first GW which is 
taken.


Jan Engelhardt
-- 
