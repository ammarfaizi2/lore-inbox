Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWAVWPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWAVWPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWAVWPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:15:50 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:5389 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id S1751378AbWAVWPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:15:50 -0500
Date: Sun, 22 Jan 2006 17:15:24 -0500 (EST)
Message-Id: <200601222215.k0MMFOYD213932@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org
Subject: [PATCH 0/4] pmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


0  index (this message)
1  add /proc/*/pmap files
2  remove /proc/*/smaps files  (depends on #1)
3  fix integer overflow  (depends on #2)
4  fix permissions  (depends on #2)

I found an old email account that still supports adding raw binay data
to an email message body. I really wish we could get away from this,
because it makes contributions damn near impossible for some people.
Other people are far worse off than I am.

These all apply to -git4, grabbed Saturday night.
