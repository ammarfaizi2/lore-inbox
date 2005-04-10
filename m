Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVDJPGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVDJPGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDJPGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:06:45 -0400
Received: from smtp.etmail.cz ([160.218.43.220]:57019 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S261507AbVDJPGn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:06:43 -0400
From: "=?UTF-8?Q?Pavel_Machek?=" <pavel@ucw.cz>
To: <alexn@dsv.su.se>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <pavel@suse.cz>
Subject: =?UTF-8?Q?Re:_2.6.12-rc2-mm2?=
Date: Sun, 10 Apr 2005 15:06:30 +0000
Message-Id: <1113145590732@pavel_ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: EMCL2 v3.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! The patch is ok, but this should be rewriten to use cpu hotplug instead. I have some patches but they need more testing. --p

-- pavel. Sent from  mobile phone. Sorry for poor formatting.
