Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUIDRfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUIDRfa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUIDRfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:35:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46488 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264937AbUIDRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:35:25 -0400
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>, Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <200409041147.35522.gene.heskett@verizon.net>
References: <Pine.LNX.4.58.0409041053450.25475@skynet>
	 <20040904103711.GD5313@devserv.devel.redhat.com>
	 <Pine.LNX.4.58.0409041418450.25475@skynet>
	 <200409041147.35522.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094315580.10555.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:33:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 16:47, Gene Heskett wrote:
> Unforch, it appears not to be available as a tarball, or group of 
> tarballs stuffed in a "grab all these" directory.  While I probably

Look harder. Its a single tarball.

> wouldn't be anything but a src of distracting questions, I still 
> wouldn't mind an opportunity to build and test (and report on the 
> grins and scowls) this if it can be built in a sandbox, leaving the 
> existing X.org-6.7 release intact for rescue recovery.  I have the 
> disk space, and plenty of cpu cycles I can steal from setiathome, so 
> thats not a major problem.

Sandbox build _should_ work now. There were problems there at one point.
Or there are vendor rpms available of the testing packages for the
brave.

