Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJKWl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 18:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbTJKWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 18:41:27 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:49320 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S263396AbTJKWl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 18:41:26 -0400
Date: Sat, 11 Oct 2003 17:41:25 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Nohez <nohez@cmie.com>
cc: linux-kernel@vger.kernel.org, smartmontools-support@lists.sourceforge.net
Subject: Re: [smartmontools-support]Reproducable time problem with SMARTD &
 XNTPD
In-Reply-To: <Pine.LNX.4.33.0310111545530.1047-100000@venus.cmie.ernet.in>
Message-ID: <Pine.GSO.4.21.0310111740320.288-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Last week we installed SMARTD on this box. SMARTD was configured to
> monitor the 6 HDDs. The time on the server started to go out of sync
> with the remote time server. And the difference increases over time.

This is the first report we've had of this type.

> SMARTD      : smartmontools-5.1.4-20

Could you please try this with the current 5.20 release of smartmontools?

Bruce

