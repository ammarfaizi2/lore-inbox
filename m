Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265243AbUFHP7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUFHP7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUFHP7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:59:31 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:59264 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265243AbUFHP7V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:59:21 -0400
Subject: Re: NFS and umount -f
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040608155414.GA3975@thumper2>
References: <20040608155414.GA3975@thumper2>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086710357.3896.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 11:59:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 08/06/2004 klokka 11:54, skreiv Andy:
> Why does this NOT do what is should be doing, i.e. umount no matter what?
> 
> Sometimes I get 
> 
> umount2 : Stale NFS file handle
> umount : machine/path: Illegal seek
> 
> and it does not umount it.
> 
> What part of
>  -f "Force unmount (in case of unreachable NFS system)" (umount man page)
> 
> does linux not understand?

Works for me...


