Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271996AbTG2SjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271997AbTG2SjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:39:23 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:28403 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271996AbTG2SjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:39:22 -0400
Subject: Re: Turning off automatic screen clanking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307291338260.6166@chaos>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org>
	 <Pine.LNX.4.53.0307291338260.6166@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059503513.6095.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 19:31:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 18:54, Richard B. Johnson wrote:
> No. There are no ANSI, nor DEC nor AT&T nor IRIS, nor IBM, nor any
> other terminals that have screen-blanking capabilities. These are
> the inventions of later-date emulations. If my DEC VT-220 screen
> went blank I would need to have it serviced.

Quite a few of the terminals did have their own screenblank, certainly
post vt220 it was very common. However nobody really used escape codes
for it. Screenblank existed to protect the display and the display spent
most of its time -not- logged into a system.

