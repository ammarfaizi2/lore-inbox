Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJ2S2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 13:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTJ2S2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 13:28:00 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:8175 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261262AbTJ2S17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 13:27:59 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: Joshua Weage <weage98@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG?: NFS client problems with 2.4.22
Date: Wed, 29 Oct 2003 19:27:56 +0100
User-Agent: KMail/1.5.3
References: <20031029170141.58468.qmail@web40405.mail.yahoo.com>
In-Reply-To: <20031029170141.58468.qmail@web40405.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291927.56249.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Previous Redhat kernels 2.4.18 to 2.4.20-20 have not displayed this
> problem.
>
> Is this a known problem with the 2.4.22 kernel?
>

Yeah it is and I think its already fixed in 2.4.23-pre8.

If you want to use 2.4.22 (2.4.21 also doesn't have this problem) :

> There should be. Try applying patches number 02, 03 and 04 (in
> that order) from
>
> http://www.fys.uio.no/~trondmy/src/2.4.23-pre7
(citation of a mail Trond Myklebust sent to the NFS-Maillinglist)


Cheers,
	Bernd
