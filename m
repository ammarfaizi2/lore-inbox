Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbTGTPFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbTGTPFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:05:13 -0400
Received: from zork.zork.net ([64.81.246.102]:49622 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266807AbTGTPFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:05:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: More ACPI funnies in 2.6.0test1
References: <1058714000.2488.2.camel@aurora.localdomain>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 20 Jul 2003 16:20:10 +0100
In-Reply-To: <1058714000.2488.2.camel@aurora.localdomain> (Trever L. Adams's
 message of "20 Jul 2003 11:13:20 -0400")
Message-ID: <6u1xwl8bth.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Trever L. Adams" <tadams-lists@myrealbox.com> writes:

> 1) My disk seems to be more active, I hear it clicking much more

Any chance this is due to increased logging activity to files that are
marked synchronous (with a -) in syslog.conf?

