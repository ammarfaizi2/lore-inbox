Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTGAOny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTGAOny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:43:54 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:9233 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262383AbTGAOnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:43:52 -0400
Date: Tue, 1 Jul 2003 15:58:12 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>, dm-devel@sistina.com
Cc: thornber@sistina.com
Subject: [RFC] device-mapper v4 ioctl interface implementation
Message-ID: <20030701145812.GA1596@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following on from the header file for the v4 ioctl interface that I
posted a couple of weeks ago, here is the first cut at the
implementation (3 patches posted as a follow up to this mail).  I hope
the v1 interface can be retired before 2.6.  Tools are not yet
available to drive this, but should be later this week.

Thoughts ?

- Joe
