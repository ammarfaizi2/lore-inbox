Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTKDLHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 06:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTKDLHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 06:07:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59527 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262221AbTKDLHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 06:07:04 -0500
Date: Tue, 4 Nov 2003 12:07:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: -bk regression against -test9
Message-ID: <20031104110703.GA217@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Current -bk does not boot (where -test9 works okay):

Null pointer dereference
EIP=dev_add_pack+0x3d
Called from irda_init, do_initcalls.

Any ideas?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
