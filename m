Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270633AbTGUS3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGUS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:29:01 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:27348
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S270633AbTGUS3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:29:00 -0400
Date: Mon, 21 Jul 2003 14:44:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ole.rohne@cern.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 8390too, radeonfb support
Message-ID: <20030721184400.GA32754@gtf.org>
References: <20030720213014.GA810@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720213014.GA810@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 11:30:14PM +0200, Pavel Machek wrote:
> Hi!
> 
> Ole put some patches on his webpage. I ported them to
> 2.6.0-test1. Could someone who has hardware test them/push them to
> linus?

Please push net driver patches to the net driver maintainer, who has
already applied the simple 8139too-refrigerator patch.

	Jeff



