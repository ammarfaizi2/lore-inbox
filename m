Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTEOPIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTEOPIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:08:30 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:55458 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264072AbTEOPIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:08:02 -0400
Date: Thu, 15 May 2003 16:21:36 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: jsimmons@infradead.org
Subject: the incredible disappearing cursor.
Message-ID: <20030515152136.GA6724@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this happen a few times, and it's starting to
happen more and more. Boots up, cursor on vesafb is blinking away.
X starts, flip back to tty1, cursor still there. sometime later
flip to X, flip to tty again, cursor is invisible.

		Dave

