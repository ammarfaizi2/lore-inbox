Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbTL3WbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbTL3WaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:30:16 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:12792 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S265903AbTL3W3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:29:44 -0500
Date: Tue, 30 Dec 2003 14:29:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [tulip] NETDEV WATCHDOG: eth0: transmit timed out
Message-ID: <20031230222929.GX1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this on 2.4.23 and 2.6.0-test10.

mii-tool and mii-diag show no problems.  How can I find if this is a driver
or hardware problem?
