Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVAYAas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVAYAas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYA3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:29:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:18636 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261725AbVAYA1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:27:38 -0500
Date: Mon, 24 Jan 2005 16:27:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-net@vger.kernel.org, lartc@mailman.ds9a.nl
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [ANNOUNCE] iproute2 (050124) release
Message-ID: <20050124162741.41606e3f@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the work of Jamal and Thomas; here is an update to iproute2.

http://developer.osdl.org/dev/iproute2/download/iproute2-2.6.10-ss050124.tar.gz

Changes since last version:
[Yun Mao]
	 fix typo in ss

[Thomas Graf]
	tc pedit/action cleanups
	add addraw_l
	rtattr_parse cleanups

[Jamal Hadi Salim]
	typo in m_mirred
	add support for pedit

[Jim Gifford]
	 Fix allocation size error in nomal and paretonormal generation
	 programs.

-- 
Stephen Hemminger	<shemminger@osdl.org>
