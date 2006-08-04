Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWHDFwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWHDFwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWHDFnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:29924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030271AbWHDFnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:21 -0400
Date: Thu, 3 Aug 2006 22:38:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 00/23] -stable review
Message-ID: <20060804053807.GA769@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 2.6.17.8 release.
There are 23 patches in this series, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a Signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the Cc:
line.  If you wish to be a reviewer, please email stable@kernel.org to
add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
received after that time might be too late.

I've also posted a roll-up patch with all changes in it if people want
to test it out.  It can be found at:

	kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz

thanks,

the -stable release team
