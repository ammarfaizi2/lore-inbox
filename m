Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUCQRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUCQRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:36:09 -0500
Received: from web9706.mail.yahoo.com ([216.136.129.241]:35214 "HELO
	web9706.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261551AbUCQRgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:36:08 -0500
Message-ID: <20040317173607.31415.qmail@web9706.mail.yahoo.com>
Date: Wed, 17 Mar 2004 09:36:07 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Active defragmentation : A replacement for bigphysarea?
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have implemented a memory defragmentation utility
for linux kernel 2.6 based on the paper by Mr. Daniel
Phillips.
Can this utility be used instead of the bigphysarea
patch, for requirements less than MAX_ORDER of
allocation ?
Can the people using the bigphysarea patch kindly
provide me with their respective memory requirements.

Alok.

__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
