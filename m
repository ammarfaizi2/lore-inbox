Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUFWVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUFWVQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUFWVNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:13:24 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:1239 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263429AbUFWVMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:12:02 -0400
Date: Wed, 23 Jun 2004 23:11:58 +0200
From: David Weinehall <tao@debian.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: path_resolution.2
Message-ID: <20040623211158.GL5811@khan.acc.umu.se>
Mail-Followup-To: Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200406232038.i5NKcTs11770.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200406232038.i5NKcTs11770.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 10:38:29PM +0200, Andries.Brouwer@cwi.nl wrote:
> In order to avoid repeating the same longish text on the man pages
> for many system calls, I wrote a man page path_resolution.2 that
> other pages can refer to.

Nice page, but shouldn't this be

7   Miscellaneous (including macro packages and conventions)

rather than

2   System calls (functions provided by the kernel)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
