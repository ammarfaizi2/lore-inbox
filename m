Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271463AbTGQOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271464AbTGQOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:31:26 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:59083 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S271463AbTGQObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:31:24 -0400
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
	installed)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307170254500.32541@montezuma.mastecende.com>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <Pine.LNX.4.53.0307160148420.32541@montezuma.mastecende.com>
	 <1058411485.4705.20.camel@aurora.localdomain>
	 <Pine.LNX.4.53.0307170254500.32541@montezuma.mastecende.com>
Content-Type: text/plain
Message-Id: <1058453171.3356.5.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-2) 
Date: 17 Jul 2003 10:46:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 02:55, Zwane Mwaikambo wrote:
> On Wed, 16 Jul 2003, Trever L. Adams wrote:
> > Sure, I sent it to the list already, here it is again.  This is some
> > time before the ethernet card driver gets loaded, etc.  Hopefully this
> > helps clear things up.
> 
> Ok it's not what i had suspected, incidentally, do you get that 'disabling 
> irq3' message every boot? Can you randomly get it to boot without that 
> occuring?

I believe it goes away completely if I turn of ACPI.   I will have to
check that later today to be sure, but I am 99% there.

Trever
--
"It was as true as taxes is. And nothing's truer than them." -- Charles
Dickens (1812-70)

