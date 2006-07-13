Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWGMWOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWGMWOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWGMWOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:14:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:36812 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030426AbWGMWOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:14:48 -0400
Date: Thu, 13 Jul 2006 15:10:08 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 0/3] 2.6.16-stable review
Message-ID: <20060713221008.GA13275@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 2.6.16.25 release.

This should also flush out the last of the 2.6.16 pending patches, and
the -stable team will turn this kernel over to Adrian Bunk now, unless
there are any outstanding issues that people raise.

There are 3 patches in this series, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a Signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the Cc:
line.  If you wish to be a reviewer, please email stable@kernel.org to
add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by Saturday, July 16 22:00:00 UTC.  Anything
received after that time, might be too late.

thanks,

greg k-h
