Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbUABTHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265570AbUABTHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:07:06 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:18295 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265567AbUABTHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:07:04 -0500
Date: Fri, 2 Jan 2004 19:07:04 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.1-rc1-mm1 with r8169 driver
Message-Id: <20040102190704.4a05092d@EozVul.WORKGROUP>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The r8169 Realtek driver hangs on bootup with the -mm1 patch but not with the plain -rc1 patch (IIRC) any ideas?

	-DaMouse
