Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUJWNRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUJWNRm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbUJWNRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:17:42 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:27335 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S261170AbUJWNRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:17:40 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Adrian Cox <adrian@humboldt.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kendall Bennett <KendallB@scitechsoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0410222210130.11567@waterleaf.sonytel.be>
References: <4176E08B.2050706@techsource.com>
	 <4177ABC9.8291.20E9CB7A@localhost> <1098434942.5755.34.camel@newt>
	 <Pine.GSO.4.61.0410222210130.11567@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1098537441.9517.15.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 14:17:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 21:10, Geert Uytterhoeven wrote:
> And the embedded solutions from Silicon Motion.

Good choice on x86, but with a couple of problems:
No big-endian 16bpp mode for PowerPC.
Poor documentation of initialisation and setting video modes.

In the end we set the video mode we wanted in Windows and copied the
register settings across to the Linux machine.

- Adrian Cox
Humboldt Solutions Ltd.



