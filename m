Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUJ3X73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUJ3X73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUJ3X5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:57:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28079 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261436AbUJ3Xze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:55:34 -0400
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099178405.1441.7.camel@krustophenia.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099178405.1441.7.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099176751.25194.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 30 Oct 2004 23:52:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 00:20, Lee Revell wrote:
> I think very few application developers understand the point Linus made
> - that bigger code IS slower code due to cache misses.  If this were
> widely understood we would be in pretty good shape.

On my laptop both Openoffice and gnome are measurably faster if you
build the lot with -Os (except a couple of image libs)

