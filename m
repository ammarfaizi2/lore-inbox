Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUH2Rmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUH2Rmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUH2Rmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:42:44 -0400
Received: from dp.samba.org ([66.70.73.150]:6355 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S268225AbUH2Rmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:42:38 -0400
Date: Sun, 29 Aug 2004 10:42:36 -0700
From: Jeremy Allison <jra@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829174236.GA21873@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093789802.27932.41.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 03:30:03PM +0100, Alan Cox wrote:
> 
> Openoffice does this in user space and the user space vfs code desktops
> use can handle zips so this "just works" already including over NFS,
> unlike a kernel proposed method.

Hurrah for OpenOffice. Now all you need to do is to
persuade Microsoft to store Word files in the same
format......

Jeremy.
