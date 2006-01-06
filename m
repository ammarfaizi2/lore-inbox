Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWAFHgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWAFHgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbWAFHgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:36:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54993 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750912AbWAFHgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:36:53 -0500
Date: Fri, 6 Jan 2006 08:36:43 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Lang <dlang@digitalinsight.com>
cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.61.0601060836020.22809@yvahk01.tjqt.qr>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> this large boot message issue also slows your boot significantly if you have a
> fast box that has a serial console, it takes a long time to dump all that info
> out the serial port.

Don't blame the kernel that serial is slow.



Jan Engelhardt
-- 
