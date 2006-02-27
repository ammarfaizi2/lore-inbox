Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWB0P2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWB0P2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWB0P2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:28:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47299 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751463AbWB0P2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:28:13 -0500
Subject: libata PATA patch for 2.6.16-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 15:32:50 +0000
Message-Id: <1141054370.3089.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is at
	http://zeniv.linux.org.uk/~alan/IDE

Some more fixes, and the ALi driver should now work although I've yet to
finish the MWDMA work or finish chasing down the slow performance.

