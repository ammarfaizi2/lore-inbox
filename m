Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVIJIB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVIJIB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVIJIB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:01:27 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:57747
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S932264AbVIJIB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:01:27 -0400
Date: Sat, 10 Sep 2005 01:01:14 -0700 (PDT)
Message-Id: <20050910.010114.28468998.davem@davemloft.net>
To: maillist@jg555.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43228E4E.4050103@jg555.com>
References: <43228E4E.4050103@jg555.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Sat, 10 Sep 2005 00:42:06 -0700

> So for my question, why does a bootloader have to be 32bit?
> Anyone got 64 bit bootloaders for Sparc or x86_64 machines?

You can make SILO 64-bit, but it would just be a lot
of work and would just result in a SILO that, unlike
current SILO, would only work on UltraSPARC machines.

32-bit SILO, on the other hand, can work on any Sparc system.

There really is no advantage, and known disadvantages, to
making SILO 64-bit.
