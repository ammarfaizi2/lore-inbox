Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTE1WqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTE1WqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:46:10 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40203 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S261411AbTE1WqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:46:09 -0400
Date: Thu, 29 May 2003 00:59:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig update
Message-ID: <Pine.LNX.4.44.0305290039240.12110-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc/patches/ there is a series of patches 
for 2.5.70 as I want to sent them soon to Linus (kconfig-2.5.70.diff.gz 
contains all the other patches). I only want to update the documentation a 
bit before this.
Changes to the last patch besides smaller fixes:
- choices should be more readable now during 'make config'
- saving configuration into a different directory fixed

bye, Roman

