Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWD3ARl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWD3ARl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 20:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWD3ARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 20:17:41 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:6736 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1750840AbWD3ARk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 20:17:40 -0400
Subject: World writable tarballs
From: Mark Rosenstand <mark@borkware.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 30 Apr 2006 02:18:06 +0200
Message-Id: <1146356286.10953.7.camel@hammer>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that at least the content of the 2.6.16 tarball is world
writable if extracted with GNU tar as an privileged user.

Is this on purpose in order to prove some point?

