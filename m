Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWI0IoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWI0IoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWI0IoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:44:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:4813 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750864AbWI0IoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:44:23 -0400
X-Authenticated: #14349625
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
From: Mike Galbraith <efault@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200609270858.43361.rjw@sisk.pl>
References: <20060926053728.GA8970@kroah.com>
	 <20060926203948.GB15674@suse.de>
	 <1159346843.6957.21.camel@Homer.simpson.net>
	 <200609270858.43361.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 10:48:31 +0000
Message-Id: <1159354112.6374.3.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 08:58 +0200, Rafael J. Wysocki wrote:

> Please try to remove the acpi_cpufreq driver before the suspend.

Yeah, that's what's causing the suspend failure.  Thanks.

> If that works, please add your system configuration to the bugzilla entry at
> http://bugzilla.kernel.org/show_bug.cgi?id=7188

When my shiny new password arrives.

	-Mike

