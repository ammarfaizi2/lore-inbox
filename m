Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbWBHGY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbWBHGY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWBHGY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:24:26 -0500
Received: from mail.polishnetwork.com ([69.222.0.23]:40970 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S1030560AbWBHGY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:24:26 -0500
Date: Wed,  8 Feb 2006 00:24:05 -0600
Message-Id: <200602080024.AA52494644@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel-2.6.16-rc2-git4 --- reiserfs write problems !!!
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-2.6.16-rc2-git4 --- reiserfs write problems

looks like with rc2 reiserfs have problem with writing - reading is ok

reiserfs is mounted on ext3 mount

with kernel-2.6.16-rc1-git6 works

any idea ???

xboom
