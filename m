Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVFQSn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVFQSn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVFQSn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:43:58 -0400
Received: from mail.linicks.net ([217.204.244.146]:50191 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262054AbVFQSnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:43:46 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Two agpgart probes at boot.
Date: Fri, 17 Jun 2005 19:43:40 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506171943.40592.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can anybody point me in the direction of why I get 'what appears' to be two 
agpgart probes on boot (2.6.11.12 on updated Slack 10):

Jun 17 18:40:27 linuxamd kernel: agpgart: Found an AGP 2.0 compliant device at 
0000:00:00.0.
Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at 
0000:00:00.0 into 4x mode
Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at 
0000:01:00.0 into 4x mode
Jun 17 18:40:27 linuxamd kernel: agpgart: Found an AGP 2.0 compliant device at 
0000:00:00.0.
Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at 
0000:00:00.0 into 4x mode
Jun 17 18:40:27 linuxamd kernel: agpgart: Putting AGP V2 device at 
0000:01:00.0 into 4x mode

TIA,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
