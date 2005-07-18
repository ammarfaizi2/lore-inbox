Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVGRQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVGRQgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 12:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGRQgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 12:36:41 -0400
Received: from adsl-69-230-3-206.dsl.pltn13.pacbell.net ([69.230.3.206]:1232
	"EHLO mailix.sanjose.privnets") by vger.kernel.org with ESMTP
	id S261837AbVGRQgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 12:36:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17115.55954.942676.450479@mailix.sanjose.privnets>
Date: Mon, 18 Jul 2005 09:36:34 -0700
From: Richard Gooch <rg+lkml0@safe-mbox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
In-Reply-To: <20050623045959.GB10386@kroah.com>
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
	<20050623010031.GB17453@mikebell.org>
	<20050623045959.GB10386@kroah.com>
X-Mailer: VM 7.03 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
> I do care about this, please don't think that.  But here's my reasoning
> for why it needs to go:
[...]
> 	- original developer of devfs has publicly stated udev is a
> 	  replacement.

Well, that's news to me!

> 	- policy in the kernel.

Like sysfs :-)

> 	- clutter and mess

In the eye of the beholder.

> 	- code is broken and unfixable

No proof. Never say never...

				Regards,

					Richard....
