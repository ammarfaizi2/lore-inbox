Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTJ1UTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTJ1UTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:19:37 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:8199 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261692AbTJ1UTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:19:36 -0500
Subject: Re: [pm] fix time after suspend-to-*
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310281019280.1023-100000@cherise>
References: <Pine.LNX.4.44.0310281019280.1023-100000@cherise>
Content-Type: text/plain
Message-Id: <1067372372.864.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 21:19:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 19:20, Patrick Mochel wrote:

> I posted the patch below to the linux-acpi list a few weeks ago. It causes
> /sbin/hotplug to be called on both suspend and resume. It's a lightweight,
> non-intrusive notification mechanism that allows only the applications
> that care about the events be notified of the transition.

I really like it. Will starting playing with it.

