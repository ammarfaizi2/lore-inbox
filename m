Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUCCWGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUCCWGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:06:36 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:50095 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261176AbUCCWGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:06:35 -0500
Subject: Resume only part of device tree?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078344202.3203.22.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Thu, 04 Mar 2004 09:03:22 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Is there any existing code in the device model that supports resuming a
part of the device tree? For Suspend2, I'm wanting to resume storage
devices (and their parents) part way through resuming, and other drivers
later.

Regards,

Nigel

