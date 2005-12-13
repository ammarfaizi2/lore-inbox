Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVLMWAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVLMWAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVLMWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:00:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:17625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030254AbVLMWAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:00:12 -0500
Date: Tue, 13 Dec 2005 13:59:36 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 0/2] 2.6.13.5 review cycle
Message-ID: <20051213215936.GA16739@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because people have asked for this, I'm flushing out the pending patches
that we had in the 2.6.13-stable queue.  Right now there are only 2
patches in here, and I've been told that people have others.  So, I'm
putting these two out for review, and saying that we will accept patches
for 2.6.13.6 also.  If anyone has anything they want to see put in,
please send them to stable@kernel.org and explicitly state that you want
the patch to go into the 2.6.13 kernel tree.  All of the normal -stable
rules (as documented in Documentation/stable_kernel_rules.txt still
apply here.)

----------------

This is the start of the stable review cycle for the 2.6.13.5 release.
There are 2 patches in this series, all will be posted as a response to
this one.  If anyone has any issues with these being applied, please let
us know.  If anyone is a maintainer of the proper subsystem, and wants
to add a signed-off-by: line to the patch, please respond with it.

These patches are sent out with a number of different people on the Cc:
line.  If you wish to be a reviewer, please email stable@kernel.org to
add your name to the list.  If you want to be off the reviewer list,
also email us.

Responses should be made by December 15, 06:00:00 UTC UTC.  Anything
received after that time, might be too late.

thanks,

the -stable release team

