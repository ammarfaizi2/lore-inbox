Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWKBOXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWKBOXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWKBOXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:23:24 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47084 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750761AbWKBOXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:23:24 -0500
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061102142320.51D7783AF9@kleikamp.austin.ibm.com>
Date: Thu,  2 Nov 2006 08:23:20 -0600 (CST)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/file.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

through these ChangeSets:

Commit: 89f68225876db7df638de2884b561facb1870239 
Author: Daniel Drake <ddrake@brontes3d.com> Mon, 30 Oct 2006 11:47:02 -0600 

    jfs: Add splice support
    
    This allows the splice() and tee() syscalls to be used with JFS.
    
    Signed-off-by: Daniel Drake <ddrake@brontes3d.com>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

