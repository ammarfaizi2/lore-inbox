Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTLBKkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTLBKkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:40:42 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:5578 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261796AbTLBKkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:40:41 -0500
From: Andrew Schulman <andrex@deadspam.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI does not power off the machine automatically
Date: Tue, 2 Dec 2003 05:40:36 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312020540.36867.andrex@deadspam.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am running 2.6.0-test10-mm1 at present
> and it does not power off the machine. It writes
> 
> acpi_power_off called
> 
> at the end and stops there. But when I press Alt+SysRQ+o,
> it switches off. 1 out of (maybe) 50 occasions, the machine
> can switch itself off automatically.
> 
> But it worked earlier, I don't know which kernel it was.

This is a known bug in 2.6: see

http://bugme.osdl.org/show_bug.cgi?id=1141
http://bugme.osdl.org/show_bug.cgi?id=1355

If you'd like to see it fixed, please consider adding your information one of 
these two bugs.

-- 
To reply by email, change "deadspam.com" to "alumni.utexas.net"

