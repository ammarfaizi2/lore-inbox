Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbULMVu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbULMVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULMVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:50:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:20645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261163AbULMVu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:50:56 -0500
Date: Mon, 13 Dec 2004 13:50:43 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200412132150.iBDLohL1016769@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.10-rc3 - 2004-12-13.8.00) - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/cifs/cifssmb.c:896: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
fs/cifs/file.c:1167: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
