Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVKRRqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVKRRqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbVKRRqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:46:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:47338 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161004AbVKRRqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:46:48 -0500
Date: Fri, 18 Nov 2005 09:30:54 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/3] Documentation updates for 2.6.15-rc1
Message-ID: <20051118173054.GA20860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 3 patches for the Documentation directory against your latest
git tree.  They add a new HOWTO file, which has been reviewed on lkml
for the past week, adds another marking to the MAINTAINERS file, and
updates the 00-INDEX file a bit.

thanks,

greg k-h

----------

 Documentation/00-INDEX |    6 
 Documentation/HOWTO    |  618 +++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS            |   16 +
 3 files changed, 640 insertions(+)

