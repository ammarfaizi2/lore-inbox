Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWCTPcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWCTPcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWCTPbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:31:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:52406 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964832AbWCTPb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:31:27 -0500
Subject: Libata PATA for 2.6.16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 15:38:15 +0000
Message-Id: <1142869095.20050.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can be found at the usual location

	http://zeniv.linux.org.uk/~alan/IDE

Some further small changes and updates, in particular the use of
platform device class for VLB/ISA/legacy IDE ports and the removal of
the "no device" special cases from the core.

Alan

