Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWJYAHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWJYAHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWJYAHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:07:46 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:23569 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422755AbWJYAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:07:45 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18: BUG: soft lockup detected on CPU#0!
Date: Wed, 25 Oct 2006 01:07:50 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610250107.50098.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After 28 days of uptime on a 2.6.18 kernel I got a mysterious lockup. When I 
went to look at the screen the only debug that made it was:

BUG: soft lockup detected on CPU#0!

The cursor had frozen and the kernel would not respond to magic sysrq.

Anybody else seen this? I had 30+ days uptime with 2.6.17..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
