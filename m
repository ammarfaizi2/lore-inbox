Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUFNSpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUFNSpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUFNSpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:45:24 -0400
Received: from web81301.mail.yahoo.com ([206.190.37.76]:21345 "HELO
	web81301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263775AbUFNSpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:45:23 -0400
Message-ID: <20040614184523.93825.qmail@web81301.mail.yahoo.com>
Date: Mon, 14 Jun 2004 11:45:23 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Can we please keep correct date when doing bk checkins?
To: linux-kernel@vger.kernel.org
Cc: Maneesh Soni <maneesh@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that while the sysfs_rename_dir-cleanup changeset was checked
in on May 14, 2004 dathes on the touched files read 2004/10/06 which is
obviously incorrect.

It would be great if bk users keep their clocks somewhat reasonable
synced.

Dmitry
