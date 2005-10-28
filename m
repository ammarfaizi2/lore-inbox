Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVJ1OxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVJ1OxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVJ1OxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:53:01 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:6276
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030206AbVJ1OxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:53:00 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: Intel D945GNT crashes with AGP enabled
Date: Fri, 28 Oct 2005 10:52:56 -0400
Message-Id: <20051028144832.M44366@linuxwireless.org>
In-Reply-To: <1130506715.5345.7.camel@blade>
References: <1130506715.5345.7.camel@blade>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 15:38:35 +0200, Marcel Holtmann wrote
> Hi guys,
> 
> I have this problem for quite some time now, but I never really got
> around to figure out what it is. I can successfully boot this machine
> and get X11 up and running, but when I shutdown my machine it crashes
> when closing X11. The system is x86_64 based and looks like this:

Marcel,

This is the Linux kernel development ML, if you have a problem, you should
really try hard to see what could be wrong.

1. oops is of good help.
2. go into a tty (ctrl+alt+f1) and try moving between runlevels and see if you
notice anything. Additionally see if this only occurs when only shuting down,
or rebooting or if also when moving from runlevels.
3. Could this also be a distro problem associated with the intel_agp module in X?

Ask yourself questions, do some googling and once you have some outputs then
maybe people can have something for you here.

.Alejandro
