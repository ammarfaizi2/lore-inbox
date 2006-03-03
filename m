Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWCCH5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWCCH5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbWCCH5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:57:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6787 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751689AbWCCH5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:57:02 -0500
Message-Id: <20060303075542.659414000@sorel.sous-sol.org>
Date: Thu, 02 Mar 2006 23:55:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 0/4] -stable review
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 2.6.15.6 release.
There are 4 patches in this series, 2 of which are simply compile fixes
for the problems with 2.6.15.5, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a Signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the
Cc: line.  If you wish to be a reviewer, please email stable@kernel.org
to add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by Sun Mar 5 08:00 UTC.  Anything received
after that time, might be too late.

thanks,
the -stable release team
--
