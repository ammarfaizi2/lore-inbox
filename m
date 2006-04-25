Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWDYJV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWDYJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWDYJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:21:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:11398 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932166AbWDYJV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:21:58 -0400
Subject: [PATCH 00/02] Process Events - Header Cleanup and License Change
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Nguyen Anh Quynh <aquynh@gmail.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 02:08:29 -0700
Message-Id: <1145956109.28976.133.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	This series of patches cleans up the Process Events header in
include/linux/cn_proc.h in the first patch and then changes the license
of cn_proc.h to LGPL in the second patch. As copyright holders to the
work the header was derived from (mentioned at the top of the header) I
think Guillaume Thouvenin and Nguyen Anh Quynh should sign-off or [n]ack
the second patch before it can go in.

	Please consider applying these to -mm.

Thanks,
	-Matt Helsley <matthltc@us.ibm.com>

