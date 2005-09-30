Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVI3UjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVI3UjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVI3UjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:39:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030380AbVI3UjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:39:03 -0400
Date: Fri, 30 Sep 2005 13:38:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, Harald Welte <laforge@gnumonks.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20050930203843.GG16352@shell0.pdx.osdl.net>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local> <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> Not for this particular USB use, there isn't. Since you can only send a 
> signal to yourself anyway, the uid/euid check is just testing that you're 
> still who you were.

Ah, I see.

thanks,
-chris
