Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUA0TOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbUA0TOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:14:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:25834 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265742AbUA0TOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:14:02 -0500
Date: Tue, 27 Jan 2004 20:13:58 +0100
From: David Weinehall <tao@debian.org>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: Andi Kleen <ak@suse.de>, Rui Saraiva <rmps@joel.ist.utl.pt>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
Message-ID: <20040127191358.GI20879@khan.acc.umu.se>
Mail-Followup-To: "Joseph D. Wagner" <theman@josephdwagner.info>,
	Andi Kleen <ak@suse.de>, Rui Saraiva <rmps@joel.ist.utl.pt>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel> <p73bropfdgl.fsf@nielsen.suse.de> <200401271251.34926.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401271251.34926.theman@josephdwagner.info>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:51:34PM -0600, Joseph D. Wagner wrote:
> > It seems that many files [1] in the Linux source have lines with
> > trailing blank (space and tab) characters and some even have formfeed
> > characters. Obviously these blank characters aren't necessary.
> 
> Actually, they are necessary.
> 
> http://www.gnu.org/prep/standards_23.html
> http://www.gnu.org/prep/standards_24.html

Let me quote CodingStyle:

"First off, I'd suggest printing out a copy of the GNU coding standards,
 and NOT read it.  Burn them, it's a great symbolic gesture."

That's how much relevance GNU's coding standards have to the kernel.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
