Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUACFjo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 00:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUACFjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 00:39:44 -0500
Received: from [66.62.77.7] ([66.62.77.7]:26520 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S262652AbUACFjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 00:39:43 -0500
Subject: Synaptics working great!
From: Dax Kelson <dax@gurulabs.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Message-Id: <1073108238.3613.16.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Jan 2004 22:37:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.6.1-rc1-mm1 on a Dell Inspiron 4150.

I after recompiled without ACPI PM timer and fixed up my XF86Config life
is excellent. I don't need to pass any parameters either.

The wacky jitter problems (fixed by patches in mm) is what kept me
running back to 2.4.

Dax Kelson


