Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVEDC7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEDC7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 22:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEDC7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 22:59:03 -0400
Received: from waste.org ([216.27.176.166]:38362 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261602AbVEDC67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 22:58:59 -0400
Date: Tue, 3 May 2005 19:58:53 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Mercurial v0.4c
Message-ID: <20050504025852.GK22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of Mercurial is available at:

 http://selenic.com/mercurial/

This version is officially self-hosting, now that I've added the final
planned changed to the metadata. To pull the repo, do:

 hg init
 hg merge http://selenic.com/hg

This version fixes numerous reported bugs, adds a "verify" command to
check the repository integrity, transaction handling, and some minor
speed improvements.

-- 
Mathematics is the supreme nostalgia of our time.
