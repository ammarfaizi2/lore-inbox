Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTLGTg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTLGTgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:36:25 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:17305 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264501AbTLGTgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:36:24 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200312071935.hB7JZxMc015085@devserv.devel.redhat.com>
To: Dax Kelson <dax@gurulabs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: USB/visor oops
In-Reply-To: <mailman.1070778724.26453.linux-kernel2news@redhat.com>
References: <mailman.1070778724.26453.linux-kernel2news@redhat.com>
Date: Sun, 7 Dec 2003 14:35:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After having had my Tre600 hotsyncing working fine with RHL9 I'm trying
> again after upgrading to Fedora. So far all I get are oops and hangs.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=107929

Try 2.4.23 as Greg says and LET ME KNOW THE RESULT, please.

> This is with the Fedora kernel 2.4.22-1.2115.nptl. This is with the uhci
> instead of usb-uhci.

Someone enabled it again? Time to have a talk with davej.

-- Pete
