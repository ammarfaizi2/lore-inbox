Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTEMQGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTEMQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:05:10 -0400
Received: from main.gmane.org ([80.91.224.249]:30402 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262000AbTEMQDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:03:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: [dri] x startup hangs again... ~2.5.69-bk5
Date: Tue, 13 May 2003 17:55:18 +0200
Message-ID: <slrnbc25b6.e5.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

downloaded 2.5.69, tried X, no more crashes on startup... life was good
downloaded 2.5.69-bk5, started X (4.3.0, DRI enabled)... instant screen
corruption and lockup. Same happens with today's bk snapshot.

used hardware:
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M6 LY

andreas

