Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUL2SsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUL2SsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 13:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUL2Sr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 13:47:59 -0500
Received: from coderock.org ([193.77.147.115]:899 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261394AbUL2Sr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 13:47:58 -0500
Date: Wed, 29 Dec 2004 19:48:25 +0100
From: Domen Puncer <domen@coderock.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229184825.GA25844@nd47.coderock.org>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost> <20041229015716.GB29323@wohnheim.fh-wedel.de> <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost> <20041229122932.GC10308@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041229122932.GC10308@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/04 13:29 +0100, Jörn Engel wrote:
> Sure.  I noticed it while going through your patch, that's all.  If
> you find the time for a second patch, that would be nice.  Casts are a
> very effective obfuscation method and most are pretty simple to avoid.
> Maybe I should check the kernel janitor list and add this point, if
> it doesn't exist yet.

It is on kj todo list, and i already did first third of files that
casted ->priv*, just didn't get around to sending patches.


	Domen
