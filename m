Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVBWE5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVBWE5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVBWE5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:57:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:38077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbVBWE5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:57:45 -0500
Date: Tue, 22 Feb 2005 20:57:55 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200502230457.j1N4vtvw013042@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.11-rc4 - 2005-02-22.16.00) - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/fs.h:24:1: warning: this is the location of the previous definition
include/linux/limits.h:4:1: warning: "NR_OPEN" redefined
