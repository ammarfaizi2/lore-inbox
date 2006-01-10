Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWAJNTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWAJNTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWAJNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:19:04 -0500
Received: from sipsolutions.net ([66.160.135.76]:2066 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932204AbWAJNTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:19:01 -0500
Message-ID: <37204.131.234.108.55.1136899119.squirrel@secure.sipsolutions.net>
In-Reply-To: <200601071649.35321.vda@ilport.com.ua>
References: <20060106042218.GA18974@havoc.gtf.org>
    <1136547084.4037.41.camel@localhost>
    <200601071649.35321.vda@ilport.com.ua>
Date: Tue, 10 Jan 2006 14:18:39 +0100 (CET)
Subject: Re: State of the Union: Wireless
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> I am confused.

Which isn't really all that surprising.

> ftp://ftp.berlios.de/pub/bcm43xx/snapshots/softmac/ieee80211softmac-20060107.tar.bz2
> which is not the same. For example, ieee80211softmac.h file exists in both
> tarballs but is not identical.
>
> Suppose one wants to use softmac in a project. What tarball contains
> the bleeding edge of softmac?

The one from the softmac page is created from the git repository. The one
on the bcm page is created from the now historical mercurial archive.

I need to get the bcm people to take away that snapshot and link to the
correct one.

johannes
