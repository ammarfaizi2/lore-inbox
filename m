Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbULQHug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbULQHug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbULQHug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:50:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37854 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262765AbULQHsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:48:03 -0500
Date: Fri, 17 Dec 2004 08:48:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net>
Message-ID: <Pine.LNX.4.61.0412170846350.14529@yvahk01.tjqt.qr>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com>
 <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com>
 <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But why creating dir in /proc - like /proc/debug is bad? Its advantages:

Like I said, /proc would need to be mounted first -- which is probably not the 
case right away when you boot with "-b" or "init=/bin/bash"



Jan Engelhardt
-- 
ENOSPC
