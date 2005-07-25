Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVGYQUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVGYQUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVGYQUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:20:36 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:15672 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261323AbVGYQUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:20:35 -0400
Date: Mon, 25 Jul 2005 18:20:33 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: msmulders@pronexus.nl, linux-kernel@vger.kernel.org
Subject: Re: help! kernel errors?
Message-ID: <20050725162033.GB23773@harddisk-recovery.com>
References: <20050725115015.zo345iawcqw0gws0@intranet.pronexus.loc> <42E4C6E7.4060806@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E4C6E7.4060806@namesys.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 03:03:03PM +0400, Vladimir V. Saveliev wrote:
> msmulders@pronexus.nl wrote:
> >Hello,
> >
> >I'm getting loads and loads of kernel errors in my syslog, but am unable to
> >decipher them into anything meaningful. 
> You may want to take a look at linux/Documentation/oops-tracing.txt

And we're only interested in the *first* Oops, not in any later one.
The first Oops is most probably the cause of all other Oopses.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
