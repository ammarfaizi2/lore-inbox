Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936493AbWLANIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936493AbWLANIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936494AbWLANIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:08:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:61886 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S936493AbWLANIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:08:48 -0500
X-Authenticated: #24128601
Date: Fri, 1 Dec 2006 14:03:59 +0100
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OHCI] BIOS handoff failed (BIOS bug?)
Message-ID: <20061201130359.GA3999@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I sometimes get this message when I boot kernel 2.6.19. Could this be
related to the BIOS option "USB keyboard support"? When I turn it off I
never get the "handoff failed" message afaik. But I need it to access
lilo. Now I use an USB->PS2 adapter and turn "USB keyboard support" off.

If "handoff failed" and "USB keyboard support" are related wouldn't it
make sense to change the USB error handling?

Regards
Sebastian
