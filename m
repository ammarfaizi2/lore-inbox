Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161357AbWJ3SyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWJ3SyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWJ3SyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:54:12 -0500
Received: from dd6424.kasserver.com ([85.13.131.51]:23236 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S1161357AbWJ3SyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:54:10 -0500
Message-ID: <45464A55.20803@feuerpokemon.de>
Date: Mon, 30 Oct 2006 19:54:13 +0100
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
Subject: ipw3945?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ipw3945 driver has been out for a while and is not yet upstream.
It requires a binary only daemon to work, but I still see no reason not
to merge it.
Many wlan drivers require binary firmware anyway, so I don't see a
reason not to merge it.
I also have read this: http://lwn.net/Articles/205988/ (and the old
thread on lkml/netdev)
Can this be used to make the driver work without the daemon?
It seems that the development of the driver has stopped since july,
maybe because it never will get merged and intel decided to stop working
on it?
If this is true it could mean that feature intel wlan chips will end up
with no linux drivers :(

please CC me ...
