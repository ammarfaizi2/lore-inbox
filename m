Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVHNNMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVHNNMl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVHNNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 09:12:40 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:40977 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932475AbVHNNMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 09:12:40 -0400
Date: Sun, 14 Aug 2005 15:13:20 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] (0/5) I2C updates for 2.4.32-pre3
Message-Id: <20050814151320.76e906d5.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I have a total of 5 patches with minor fixes to the Linux 2.4 i2c
subsystem and documentation. These fixes I gathered for the past few
months as they were applied to the Linux 2.6 tree and to the i2c CVS
repository.

Individual patches will be posted in reply to this post, with
explanations and diffstat. Please consider applying them.

Thanks.

 Documentation/i2c/dev-interface   |    4 ++--
 Documentation/i2c/functionality   |    2 +-
 Documentation/i2c/writing-clients |    2 +-
 MAINTAINERS                       |    2 +-
 drivers/i2c/i2c-core.c            |   10 +++++-----
 drivers/i2c/i2c-dev.c             |    2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
Jean Delvare
