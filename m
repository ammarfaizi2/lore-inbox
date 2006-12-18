Return-Path: <linux-kernel-owner+w=401wt.eu-S1753621AbWLRJXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbWLRJXz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbWLRJXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:23:55 -0500
Received: from hera.kernel.org ([140.211.167.34]:60751 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbWLRJXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:23:54 -0500
Date: Mon, 18 Dec 2006 09:23:52 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Linux 2.4.33.6
Message-ID: <20061218092352.GA19837@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same fixes as in 2.4.34-rc3.
This one fixes CVE-2006-4814.

Willy

Summary of changes from v2.4.33.5 to v2.4.33.6
============================================

Hugh Dickins (1):
      zeromap may find a pte

Linus Torvalds (1):
      Fix incorrect user space access locking in mincore() (CVE-2006-4814)

Willy Tarreau (1):
      Change VERSION to 2.4.33.6

