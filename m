Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270006AbUJHRAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270006AbUJHRAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270023AbUJHRAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:00:14 -0400
Received: from users.linvision.com ([62.58.92.114]:29645 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S270006AbUJHQ7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:59:54 -0400
Date: Fri, 8 Oct 2004 18:59:53 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Roland Dreier <roland@topspin.com>
Cc: Alan Kilian <kilian@bobodyne.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver access ito PCI card memory space question.
Message-ID: <20041008165952.GA32032@harddisk-recovery.com>
References: <200410062020.i96KKPN13520@raceme.attbi.com> <52llejpiwu.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52llejpiwu.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 03:43:13PM -0700, Roland Dreier wrote:
> The "Linux Device Drivers" online book, available at
> <http://www.xml.com/ldd/chapter/book/> will probably be pretty
> helpful.  In fact if you're serious about writing drivers, you should
> buy a dead-tree copy.

Note that LDD is focused on 2.4, but LWN has a nice series of articles
that describes how to port 2.4 drivers to 2.6:

  http://lwn.net/Articles/driver-porting/

LDD should give you the basics, the articles on lwn.net should tell you
what's different.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
