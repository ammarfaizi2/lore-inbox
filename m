Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVINGuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVINGuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVINGuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:50:23 -0400
Received: from 84-72-89-103.dclient.hispeed.ch ([84.72.89.103]:53921 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S965053AbVINGuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:50:22 -0400
Date: Wed, 14 Sep 2005 08:50:10 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Search in make menuconfig doesn't work properly
Message-ID: <20050914065010.GA8430@kestrel.twibright.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2.6.13 and if I press '/' in make menuconfig (Search
Configuration Parameter, Enter Keyword) and enther "emulation", it
doesn't find
CONFIG_BLK_DEV_IDESCSI -  SCSI emulation support.

CL<
