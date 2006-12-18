Return-Path: <linux-kernel-owner+w=401wt.eu-S1754203AbWLRQJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbWLRQJa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbWLRQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:09:29 -0500
Received: from frodo.hserus.net ([204.74.68.40]:34455 "EHLO frodo.hserus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbWLRQJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:09:29 -0500
X-Greylist: delayed 1595 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 11:09:29 EST
To: linux-kernel@vger.kernel.org
From: jidanni@jidanni.org
Subject: kernel-parameters.txt: expand APIC
Message-Id: <E1GwIj5-0000iP-KJ@jidanni.org>
Date: Mon, 18 Dec 2006 21:40:19 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-parameters.txt says what ACPI and APM stand for, but not APIC.
Also there give some basic apm related parameters, instead of just
saying see apm.c, which the user is less likely to have handy than
kernel-parameters.txt.
