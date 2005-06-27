Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVF0Ef6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVF0Ef6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVF0Ef6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:35:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:38020 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261807AbVF0Efy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:35:54 -0400
Subject: kbuild warnings with current git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 14:31:09 +1000
Message-Id: <1119846670.5133.101.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/Kconfig:551:warning: type of 'TCP_CONG_BIC' redefined from 'tristate' to 'boolean'

net/ipv4/Kconfig:92:warning: defaults for choice values not supported


Ben.


