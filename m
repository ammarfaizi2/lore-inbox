Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVCOXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVCOXpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVCOXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:44:51 -0500
Received: from web26510.mail.ukl.yahoo.com ([217.146.176.47]:23692 "HELO
	web26510.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262138AbVCOXoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:44:16 -0500
Message-ID: <20050315234415.71730.qmail@web26510.mail.ukl.yahoo.com>
Date: Tue, 15 Mar 2005 23:44:15 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: NFS client bug in 2.6.8-2.6.11
To: Bernardo Innocenti <bernie@develer.com>, Anders Saaby <as@cohaesio.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernardo (et al).  Apologies - I've not been reading my account for
a wee while.  Then again, I probably don't have much useful to add to
the debate right now ;-)

--- Bernardo Innocenti <bernie@develer.com> wrote:
> Anders Saaby wrote:
> > Anyways if your server has only run with 2.6.10 - try 2.6.11.
> 
> Thank you, I've finally nailed it down by upgrading the
> *server* kernel from 2.6.10-1.770_FC3 to 2.6.10-1.770_FC3.

Hmm, I will infer from a previous email you sent that you mean 766_FC3
for the "from" kernel.

> The latter is basically 2.6.10-ac12 plus a bunch of vendor
> specific patches.

766 -> 770 sounds like a "small" (ish) number of patches to check, if
we're lucky.  Did you wade through 'em all yet?  Any smoking guns?

Regards,
Neil
PS: oh bugger, just remembered that I also reproduced my bug with a
2.6.8 kernel on the server; admittedly though it was an FC2 kernel so
who knows what extra patches it had.



		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs
