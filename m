Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTDEWMT (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTDEWMT (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:12:19 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:31120 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S262690AbTDEWMS (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:12:18 -0500
Date: Sun, 6 Apr 2003 00:24:12 +0200 (CEST)
From: Stephan van Hienen <kernel@ddx.a2000.nu>
To: Andre Hedrick <andre@linux-ide.org>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <Pine.LNX.4.10.10304051337470.29290-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.53.0304060006190.18036@ddx.a2000.nu>
References: <Pine.LNX.4.10.10304051337470.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Andre Hedrick wrote:

>
> NO, since they all use the same timings there is no problem.
> Intel never made an Ultra 133, and all the timings from PIIX forward build
> on each other.
i didn't say anything about u133 ?
(hdparm -x69 = udma5/u100 ?)

>
> There is no bug, except in your BIOS maybe.
in my bios i didn't select any drives (i thought linux was just bypassing
bios for disk access ?)
so why can't i use u100 with the onboard controller ? (which is an u100
controller)
