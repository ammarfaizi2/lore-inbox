Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161510AbWJKV2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161510AbWJKV2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWJKVFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:05:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:15774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161387AbWJKVEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:04:43 -0400
Date: Wed, 11 Oct 2006 14:03:10 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: [patch 00/67] 2.6.18-stable review
Message-ID: <20061011210310.GA16627@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 2.6.18.1 release.
There are 67 patches in this series, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a Signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the Cc:
line.  If you wish to be a reviewer, please email stable@kernel.org to
add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by Friday, October 13, 20:00:00 UTC.  Anything
received after that time might be too late.

And yes, we realize that this is a large number of patches, sorry, we
have been a bit slow in responding lately.  If there are any patches
that have been sent to us for the 2.6.18-stable tree, that are not in
this series, please resend them, as we think we are finally caught up
with this work.

An all-in-one patch for this series can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.18.1-rc1.gz
if anyone wants to test this out that way.

thanks,

the -stable release team
