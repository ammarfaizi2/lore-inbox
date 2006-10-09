Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932946AbWJIPcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932946AbWJIPcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbWJIPcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:32:15 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:44740 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932937AbWJIPcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:32:11 -0400
Date: Mon, 9 Oct 2006 11:32:07 -0400
From: Chris Mason <chris.mason@oracle.com>
To: linux-kernel@vger.kernel.org
Subject: [CFT] new patch and reject merging tool
Message-ID: <20061009153207.GU8689@think.oraclecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've reworked my rej code somewhat into a new utility that can apply
unified diffs and git diffs (git patch support is from Brendan Cully).

It has a mode for auto-resolving rejects, but by default it is as safe
as patch, and much faster than rej was.

Download locations and details are here:

http://oss.oracle.com/~mason/mpatch/

-chris

