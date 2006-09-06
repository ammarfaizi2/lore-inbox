Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWIFXOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWIFXOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIFXOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:14:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:60107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964858AbWIFXA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:56 -0400
Date: Wed, 6 Sep 2006 15:54:44 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 00/37] -stable review
Message-ID: <20060906225444.GA15922@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for next 2.6.17.y release.
There are 37 patches in this series, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a Signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the Cc:
line.  If you wish to be a reviewer, please email stable@kernel.org to
add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by Fri Sep 8 22:00:00 UTC.  Anything received
after that time might be too late.

Full patch of this whole series is available at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.12-rc1.gz
if you wish to test it out and make sure nothing is broken on your
architecture or system.

thanks,

greg k-h
