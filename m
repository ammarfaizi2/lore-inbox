Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbTCOJJa>; Sat, 15 Mar 2003 04:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbTCOJJa>; Sat, 15 Mar 2003 04:09:30 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:57360 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S261349AbTCOJJ3>; Sat, 15 Mar 2003 04:09:29 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200303150920.h2F9KGm16328@mako.theneteffect.com>
Subject: Re: [PATCH] update filesystems config. menu
To: davej@codemonkey.org.uk (Dave Jones)
Date: Sat, 15 Mar 2003 03:20:16 -0600 (CST)
Cc: "Randy.Dunlap"@mako.theneteffect.com, <randy.dunlap@verizon.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030315094151.GA16373@suse.de> from "Dave Jones" at Mar 15, 2003 08:41:57 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note the ordering, ext3 gets tried before ext2.

Was thinking of the "ext3 clings to you like flypaper" thread of a couple
weeks ago, only backwards... -ESLEEPY

Anyway, I have seen instances where root got mounted ext2 instead of ext3
(faulty initrd or whatever it was) - just wondered if the help should really
push people to unreservedly say Y to ext2 if their root is really ext3...

	M
