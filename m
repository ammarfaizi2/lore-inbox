Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEMQnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTEMQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:43:53 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:63891 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261688AbTEMQnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:43:52 -0400
Date: Tue, 13 May 2003 17:56:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andreas Happe <andreashappe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dri] x startup hangs again... ~2.5.69-bk5
Message-ID: <20030513165647.GA1056@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andreas Happe <andreashappe@gmx.net>, linux-kernel@vger.kernel.org
References: <slrnbc25b6.e5.andreashappe@flatline.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnbc25b6.e5.andreashappe@flatline.ath.cx>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:55:18PM +0200, Andreas Happe wrote:
 > downloaded 2.5.69, tried X, no more crashes on startup... life was good
 > downloaded 2.5.69-bk5, started X (4.3.0, DRI enabled)... instant screen
 > corruption and lockup. Same happens with today's bk snapshot.
 > 
 > used hardware:
 > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
 > M6 LY

Can you try with the drivers/char/agp changes backed out ?

What motherboard chipset ?

		Dave

