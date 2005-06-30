Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVF3KVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVF3KVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVF3KU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:20:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4334 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262815AbVF3KUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:20:21 -0400
Subject: Re: FUSE merging?
From: Arjan van de Ven <arjan@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	 <1120125606.3181.32.camel@laptopd505.fenrus.org>
	 <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 12:20:03 +0200
Message-Id: <1120126804.3181.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 12:12 +0200, Miklos Szeredi wrote:
> > if you are so interested in getting fuse merged... why not merge it
> > first with the security stuff removed entirely. And then start
> > discussing putting security stuff back in ?
> 
>   a) it's already been discussed to death (just search for 'fuse' on
>      lkml and fsdevel)
> 
>   b) I don't consider it a good idea to ship a defunct version of it in
>      the mainline
> 
> Can you please accept my wish to have FUSE merged _with_ the
> unprivileged mount's thing.

By the same argument:
Then can you please accept that FUSE will not get merged right now.


