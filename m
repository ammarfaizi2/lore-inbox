Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUAJC2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 21:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAJC2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 21:28:38 -0500
Received: from gaia.cela.pl ([213.134.162.11]:14863 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264870AbUAJC2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 21:28:34 -0500
Date: Sat, 10 Jan 2004 03:27:35 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Christoph Hellwig <hch@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       <Valdis.Kletnieks@vt.edu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
In-Reply-To: <1073694475.6189.176.camel@nomade>
Message-ID: <Pine.LNX.4.44.0401100325320.1739-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Like binfmt_flat? :)
> 
> .. or even zflat. Not that I'm proud of it, but it can effectively
> manage to produce rather compact executables :)

Probably one of those two, is this something new?  Never heard of 
either... :) Specs? Min bin file size?  If this (one of these) is 
guaranteed to be in any new kernel (i.e. can't be configed out like a.out) 
then that would be enough (assuming this flat is slim file size wise).

Cheers,
MaZe.


