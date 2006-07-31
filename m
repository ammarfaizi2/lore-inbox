Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWGaTTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWGaTTM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWGaTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:19:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49353 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030338AbWGaTTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:19:11 -0400
Message-ID: <44CE57A1.6090407@sgi.com>
Date: Mon, 31 Jul 2006 12:18:57 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: [patch 0/3] CSA accounting and taskstats update
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Following are a set of patches that would add basic accounting
fields and csa accounting fields to taskstats struct and would
send those accounting data to userspace over taskstats interface.

Patches were created against 2.6.18-rc2.

taskstats-acct.patch
taskstats-csa.patch
csa-bsd-acct-update.patch

Regards,
   Jay Lan <jlan@sgi.com>


