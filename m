Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTKZRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTKZRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:17:25 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:40064
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264268AbTKZRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:17:24 -0500
Date: Wed, 26 Nov 2003 12:16:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Vince <fuzzy77@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
In-Reply-To: <3FC4DA17.4000608@free.fr>
Message-ID: <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
References: <3FC4DA17.4000608@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Vince wrote:

>    I get a kernel panic each time I'm rebooting my system on all
> recent 2.6.0testx kernels (cpu is an Athlon 1800XP, kernel compiled with
> preempt and ACPI ; config and dmesg is attached).
>
>    This time, I got tired of seeing this and finally installed kmsgdump
> in order to collect some data, available in messages.txt (*)
>
> For my particular case, X was not loaded: I just logged in in console
> mode and did a reboot. No nvidia or other binary driver loaded. Any hint
> on tracking down this bug is appreciated (I can compile my kernel with
> additional debugging options if required).

I can't see the first oops, it looks like it's been spewing them out for a
while too;

<4>Oops: 0000 [#49]

At the point you're at there really isn't much state left to work from.
Any chance you can get at the logs (if it hit disk) and get the first
oops?

