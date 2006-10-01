Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWJAU1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWJAU1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWJAU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:27:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:16863 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932320AbWJAU1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:27:41 -0400
Date: Sun, 1 Oct 2006 22:27:37 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Dvorkin Dmitry <dvorkin@flightmedia.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic94xx
Message-ID: <20061001202737.GB22787@rhun.haifa.ibm.com>
References: <45202519.3030809@flightmedia.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45202519.3030809@flightmedia.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:29:13AM +0400, Dvorkin Dmitry wrote:

> does anybody have success with aic94xx or adp94xx running in Xen 3?

You should probably direct Xen questions to the Xen users or
developers mailing list.

I have Xen running happily with various versions of adp94xx and
aic94xx. aic94xx has recently been merged into the mainline Linux
kernel (as of 2.6.19-rc1, which isn't out yet) but Xen is currently at
2.6.16.29, so it will take a bit for it to trickle down.

Cheers,
Muli
