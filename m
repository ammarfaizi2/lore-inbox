Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUHVVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUHVVtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUHVVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:49:37 -0400
Received: from the-village.bc.nu ([81.2.110.252]:17552 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266775AbUHVVrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:47:39 -0400
Subject: Re: Linux Incompatibility List
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David N. Welton" <davidw@dedasys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87vffaq4p1.fsf@dedasys.com>
References: <87r7q0th2n.fsf@dedasys.com>
	 <1093173291.24341.40.camel@localhost.localdomain>
	 <87vffaq4p1.fsf@dedasys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093207525.25067.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 21:45:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 21:48, David N. Welton wrote:
> A "compatibility list" is going to be pretty big, and hard to keep up
> to date.  My thinking is that keeping track of a few notable things
> that don't work is easier than running after all the stuff that does.

Its already been kicked around on the Fedora list to actually build such
a database automatically. I've seen similar Debian proposals a long time
ago. That means some time post install you'd let the user
fire up a system report tool which would ask things like

	"Does sound work"

and then fire off PCI id/rating info to a central site. That would help
deal with the data collection much as the Debian folks collect package
popularity statistics.

> I suppose some sort of vote system could be put in place so that the 1
> guy who didn't get the hardware to work gets outvoted by the 10 who
> did, but there is more incentive to hit the button when you are
> irritated than when everything 'just worked'.

If you get enough data then the deviation tells you how varied and how
reliable the opinions are likely to be, all this implies databases not
WIki however


Alan

