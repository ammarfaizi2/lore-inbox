Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTLFJrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 04:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTLFJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 04:47:12 -0500
Received: from main.gmane.org ([80.91.224.249]:4554 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264894AbTLFJrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 04:47:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: Which optimization for different CPUs?
Date: Sat, 06 Dec 2003 10:47:10 +0100
Message-ID: <bqs8iq$2c3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have several servers and workstations. What optimization level in the
kernel configuration is the maximum possible if I want to use the same
kernel 

- on a Duron-650, a Celeron-1000, and a Celeron-2600?  (servers)
- additionally on a K6-3D 400 and a K6-2 350?
  (do I *have* to go down to CONFIG_M586 or does P2 or P-MMX work?)

- on a P3-700, an Athon XP 2400, and a P4-1800+? (workstations)


Thank you!


-- 
Jens Benecke
