Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFBPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFBPjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUFBPjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:39:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263184AbUFBPjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:39:46 -0400
Date: Wed, 2 Jun 2004 16:39:27 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 0/5: Device-mapper: snapshots and mirrors
Message-ID: <20040602153927.GM6302@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Five long-anticipated patches for device-mapper for snapshots and mirrors.
dm-zero provides a zero block device: Taking a writeable snapshot 
of this gives you a sparse device.

Alasdair
-- 
agk@redhat.com
