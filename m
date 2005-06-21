Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVFUGb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVFUGb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVFUG3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:29:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:62434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261704AbVFUG2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:28:53 -0400
Date: Mon, 20 Jun 2005 23:28:43 -0700
From: Greg KH <gregkh@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050621062843.GA15062@kroah.com>
References: <200506181332.25287.nick@linicks.net> <200506202000.08114.nick@linicks.net> <20050620192118.GA13586@suse.de> <200506202032.30771.nick@linicks.net> <Pine.LNX.4.62.0506201242100.13723@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506201242100.13723@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 12:42:39PM -0700, David Lang wrote:
> I ran into the same issue last week on fedora core 3 so it's not _just_ a 
> slackware problem.

FC 3, with default udev install will not boot with 2.6.12?  What version
of udev is the latest for FC3?

thanks,

greg k-h
