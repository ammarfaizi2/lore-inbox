Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422849AbWCXKpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422849AbWCXKpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 05:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWCXKpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 05:45:53 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:42453 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1422849AbWCXKpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 05:45:52 -0500
X-Originating-IP: [145.64.134.242]
From: "David =?UTF-8?Q?H=C3=A4rdeman?=" <david@2gen.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, "Dominik Brodowski" <linux@brodo.de>
In-Reply-To: <20060324014634.GU22727@stusta.de>
Subject: Re: [RFC: 2.6 patch] the overdue removal of drivers/pcmcia/pcmcia_ioctl.c
Date: Fri, 24 Mar 2006 11:45:48 +0100
Message-ID: <20060324.zeM.28118800@www.hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: AngleMail for eGroupWare (http://www.egroupware.org) v 1.0.0.007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk (bunk@stusta.de) wrote:
>
> This patch contains the overdue removal of drivers/pcmcia/pcmcia_ioctl.c
> plus the fallout of additional cleanups after this removal.
...
>  Documentation/feature-removal-schedule.txt |   17

How about moving the pcmcia ioctl entry from feature-removal-schedule.txt to a
new file (say...removed-features.txt) so that its easy to find a list of
removed features and why /when they were removed when upgrading the kernel?

