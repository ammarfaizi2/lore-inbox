Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTEZSZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEZSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:25:06 -0400
Received: from customer-mpls-23.cpinternet.com ([209.240.253.23]:39786 "EHLO
	mharnois.mdharnois.net") by vger.kernel.org with ESMTP
	id S261959AbTEZSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:25:05 -0400
Subject: radeon.ko missing mmu_cr4_features
From: "Michael D. Harnois" <mharnois@cpinternet.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053974297.6528.1.camel@mharnois.mdharnois.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 13:38:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.69-bk1[89] radeon.ko will not load: 

May 26 13:36:58 mharnois kernel: radeon: Unknown symbol mmu_cr4_features




