Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUHOFKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUHOFKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 01:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHOFKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 01:10:40 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:36074 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S266495AbUHOFKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 01:10:39 -0400
Date: Sat, 14 Aug 2004 22:10:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org, bitkeeper-announce@work.bitmover.com
Subject: BK-3.2.3 released
Message-ID: <20040815051037.GA3795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, bitkeeper-announce@work.bitmover.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release notes in the download area.  Notable new features are 

    - commit templates
    - tabwidth configuration for you non-8 char folks
    - import -tpatch sent in by Stephen Hemminger
    - put the BK bin back in the path at the end when calling a trigger
    - bk clean will no clean things which were just chmod +w and have no diffs
    - some performance fixes for large ChangeSet files (i.e., linux kernel)

Enjoy and let us know what doesn't work.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
