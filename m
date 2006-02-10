Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWBJWme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWBJWme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBJWme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:42:34 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:49096 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751386AbWBJWmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:42:33 -0500
Date: Fri, 10 Feb 2006 23:42:38 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Linux-LKLM <linux-kernel@vger.kernel.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Message-ID: <20060210224238.GA5713@stiffy.osknowledge.org>
References: <20060210214122.GA13881@stiffy.osknowledge.org> <20060210222515.GA4793@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210222515.GA4793@mipter.zuzino.mipt.ru>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g418aade4-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexey Dobriyan <adobriyan@gmail.com> [2006-02-11 01:25:15 +0300]:

> On Fri, Feb 10, 2006 at 10:41:22PM +0100, Marc Koschewski wrote:
> > I just wanted to mount an external USB HDD... this was what I got:
> 
> > [4297455.819000] EIP:    0060:[<c01ee88e>]    Tainted: P      VLI
> 
> Kindly reproduce without proprietary modules loaded.

I knew this would be the response. :) Unfortunately I cannot reproduce. I just
remounted the disk 6 times, via fstab and 'by hand'. Also rebooted with the
thing attached and just plugged it into the running system. No chance ... always
worked as expected.

Marc
