Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTLFWy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTLFWy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:54:56 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:23302 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S265265AbTLFWyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:54:55 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200312062254.RAA26015@clem.clem-digital.net>
Subject: 260t11-bk4 problem -- hung processes
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 6 Dec 2003 17:54:54 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.0-t11-bk4, mozilla hangs before it can come up.
At this point other processes that touch the associated
/proc entries hang also (such as a ps). Can not kill the
process. Shutdown also hangs.

Everything fine with bk3.

-- 
Pete Clements 
