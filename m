Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTELRfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTELRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:35:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61595 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262367AbTELRfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:35:42 -0400
Date: Mon, 12 May 2003 10:43:39 -0700
From: Greg KH <greg@kroah.com>
To: Mace Moneta <mmoneta@optonline.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.21-rc2 kernel panic USB sched.c:564
Message-ID: <20030512174339.GA28550@kroah.com>
References: <1052600695.12657.4.camel@optonline.net> <20030511054554.GB7729@kroah.com> <1052661635.30223.26.camel@optonline.net> <20030512164948.GA28136@kroah.com> <1052760652.25189.4.camel@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052760652.25189.4.camel@optonline.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 01:30:52PM -0400, Mace Moneta wrote:
> I replaced usb-uhci with uhci, and tried to recreate the problem.  While
> this is easily recreated with usb-uhci, even after 30 attempts uhci
> operated without error.

Great, I'd recommend sticking with uhci then :)

Glad it's working for you,

greg k-h
