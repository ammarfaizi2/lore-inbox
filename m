Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCZSEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCZSEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVCZSEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:04:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:9894 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261200AbVCZSE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:04:28 -0500
Date: Sat, 26 Mar 2005 19:06:27 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] cifs: inode.c cleanup - function definitions
 (whitespace changes only)
In-Reply-To: <200503261944.47012.adobriyan@mail.ru>
Message-ID: <Pine.LNX.4.62.0503261903490.2488@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503261456390.2488@dragon.hyggekrogen.localhost>
 <200503261944.47012.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Alexey Dobriyan wrote:

> Looks like code in fs/cifs/ align parameters after bracket.
> 

When I started doing these cleanups I asked Steve if the form I'd chosen 
was OK with him - several styles were in use in different files (and even 
within files, so I picked one style to make consistent), and he indicated 
that the style I'd picked was OK by him. Once I get through all the files 
it'll be consistent throughout. 

-- 
Jesper


