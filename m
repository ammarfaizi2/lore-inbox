Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVFTTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFTTZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVFTTZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:20933 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261534AbVFTTYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:24:32 -0400
Date: Mon, 20 Jun 2005 21:24:30 +0200
From: Olaf Hering <olh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, Denis Vlasenko <vda@ilport.com.ua>,
       Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050620192430.GA2838@suse.de>
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <20050620164800.GA14798@suse.de> <42B6FBC7.5000900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42B6FBC7.5000900@pobox.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jun 20, Jeff Garzik wrote:

> That's lame.  The kernel should support udev's out in the field, on 
> people's boxes (RHEL, SLES?, Fedora, ...).

The udev package as shipped with SLES9 works just fine with every kernel
version. Modulo the scsi targetN changes in sysfs layout, but that
doesnt prevent booting.
