Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVI0UIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVI0UIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVI0UIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:08:38 -0400
Received: from [81.2.110.250] ([81.2.110.250]:24971 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750956AbVI0UIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:08:37 -0400
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
	Oops while completing async USB via usbdevio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509270943400.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>
	 <20050927160029.GA20466@master.mivlgu.local>
	 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
	 <1127840281.10674.5.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509270943400.3308@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 21:35:17 +0100
Message-Id: <1127853317.10674.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-27 at 09:59 -0700, Linus Torvalds wrote:
> 
> On Tue, 27 Sep 2005, Alan Cox wrote:
> > 
> > Which doesn't take very long to arrange. Relying on pids is definitely a
> > security problem we don't want to make worse than it already is. 
> 
> The thing is, the current code is _worse_. 
> 
> MUCH worse.

Violent agreement

