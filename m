Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWJAUBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWJAUBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWJAUBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:01:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:11211 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932271AbWJAUBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:01:33 -0400
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Please report all left over "DWARF2 unwinder stucks"
Date: Sun, 1 Oct 2006 22:01:20 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610012201.20544.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All the fixes for known "DWARF2 unwinder stuck at ..." are
in Linus -git mainline now.

If you still see any with current -git please report them.

Thanks,

-Andi
