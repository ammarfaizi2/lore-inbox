Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTLUCrj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLUCrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:47:39 -0500
Received: from linux-bt.org ([217.160.111.169]:48039 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262038AbTLUCri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:47:38 -0500
Subject: Difference between select and enable in Kconfig
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1071974814.2684.41.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 03:46:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while porting some of my drivers to 2.6 which use the firmware loader
for example I came to the question whether to use select or enable to
achieve the desired result. Looking at the documention don't gives me
the answer and from zconf.l I feel that both options are the same. Can
anyone please explain me the differences if there are any?

Regards

Marcel


