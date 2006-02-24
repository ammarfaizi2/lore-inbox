Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWBXL7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBXL7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 06:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBXL7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 06:59:14 -0500
Received: from corky.net ([212.150.53.130]:43738 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S1750746AbWBXL7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 06:59:13 -0500
Message-ID: <43FF0357.3010106@corky.net>
Date: Fri, 24 Feb 2006 13:00:07 +0000
From: Just Marc <marc@corky.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mirrors@mirrormonster.com
Subject: Re: 3ware 9550SX-ML16 controller weird pci bus parity errors
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've also been experiencing similar PCI parity error prints lately on
fairly recent hardware, shortly after the prints show up the syscam
sometimes just locks up without further prints / panics, running recent
kernels -- 2.6.14+. 

Can anyone please shed some light on what can cause such errors, how can
they be debugged / addressed?

Marc
