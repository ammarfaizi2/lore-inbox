Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271916AbTGRXMO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271921AbTGRXMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:12:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:51425 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271916AbTGRXMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:12:12 -0400
Date: Fri, 18 Jul 2003 16:26:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Ricardo Galli <gallir@uib.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Message-ID: <42670000.1058570801@[10.10.2.4]>
In-Reply-To: <20030718142720.40983f6a.akpm@osdl.org>
References: <200307181228.40142.gallir@uib.es><20030718140019.4f6667bd.akpm@osdl.org><200307182313.23288.gallir@uib.es> <20030718142720.40983f6a.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> $ apt-cache show fam
> 
> I was attacked by dselect as a small child and have since avoided debian. 
> Is there a tarball anywhere?

Fear ye not the perils of dselect and associated evils.
Though it is, admittedly, one of the most user-malevolent tools known to
man, with a UI designed by sadistic perverts from the very bowels of this
earth, you don't need to use it to run debian (I never do). apt will do
everything you need to do.

But, leaving aside for a moment, the holy crusade of righteousness ...

----------------------

NAME
       deb - Debian binary package format

SYNOPSIS
       filename.deb

...

FORMAT
       The  file is an ar archive with a magic number of !<arch>.

-----------------------

So it should be pretty easy to rip what you want out of there. If that
doesn't work, I'll make you a tarball ;-)

M.

