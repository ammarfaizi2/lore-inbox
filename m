Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265809AbUGHGP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUGHGP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUGHGP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:15:56 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:21652 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265809AbUGHGPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:15:54 -0400
Date: Thu, 8 Jul 2004 08:15:51 +0200
From: David Weinehall <tao@acc.umu.se>
To: tom st denis <tomstdenis@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>, Gabriel Paubert <paubert@iram.es>,
       linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040708061551.GB10540@khan.acc.umu.se>
Mail-Followup-To: tom st denis <tomstdenis@yahoo.com>,
	Christoph Hellwig <hch@infradead.org>,
	Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
References: <20040707184737.GA25357@infradead.org> <20040707185340.42091.qmail@web41112.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707185340.42091.qmail@web41112.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:53:40AM -0700, tom st denis wrote:
[snip]
> And I don't need mr. Viro coming down off his mountain saying "oh you
> fail it" because I don't know some obscure typing rule that I wouldn't
> come accross because *** I AM NOT LAZY ***.  Hey mr. Viro what have you
> contributed to the public domain lately?  Anything I can harp on in
> public and abuse?  

Well, look at it this way...  Alexander Viro is one of very few persons
in the world that I'd trust enough to take unaudited code from and apply
to my own projects.

Oh, and you're using his works every day I suppose; he's behind most of
the VFS of the kernel.  Read the bloody changelogs for the kernel
instead of whining.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
