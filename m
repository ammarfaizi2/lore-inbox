Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbTGLRuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268123AbTGLRuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:50:03 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:63864 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268098AbTGLRuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:50:01 -0400
From: Bob Johnson <livewire_@ameritech.net>
Reply-To: livewire_@Ameritech.net
To: linux-kernel@vger.kernel.org
Subject: siimage in 2.5
Date: Sat, 12 Jul 2003 13:03:02 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121303.02950.livewire_@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


echo "max_kb_per_request:15" >/proc/ide/hde/settings

Works for 2.4.21 kernels to keep from locking up when enabling
the proper mode and dma when using a siimage and seagate sata drives.

Is there a equivalent command for 2.5, or a way hard code this?


					Bob

