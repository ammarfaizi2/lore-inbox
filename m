Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbUB0OID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbUB0OID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:08:03 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7364 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262878AbUB0OIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:08:01 -0500
Date: Fri, 27 Feb 2004 09:07:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dan Creswell <dan@dcrdev.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard locks under high interrupt load?
In-Reply-To: <403F4D24.6040802@dcrdev.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0402270907130.17504@montezuma.fsmlabs.com>
References: <403F2237.6080505@dcrdev.demon.co.uk>
 <Pine.LNX.4.58.0402270744240.17504@montezuma.fsmlabs.com>
 <403F4D24.6040802@dcrdev.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Dan Creswell wrote:

> This box is running Fedora Core 1 and so, yes, it's running a userspace
> balance daemon (Redhat's).
>
> I'll try out the noirqbalance option and get back to the list on that one.

Could you also give a test run without the userspace balancer daemon and
only the kernel one.

Thanks

