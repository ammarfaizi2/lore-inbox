Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUA0Rit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUA0Rit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:38:49 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:64474 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263637AbUA0Ris (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:38:48 -0500
Date: Tue, 27 Jan 2004 18:38:46 +0100
From: David Weinehall <tao@debian.org>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [2.0.40-rc8] Works well
Message-ID: <20040127173846.GG20879@khan.acc.umu.se>
Mail-Followup-To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <1075223456.5219.1.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1075223456.5219.1.camel@midux>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 07:10:56PM +0200, Markus Hästbacka wrote:
> Hey David,
> I just mail to tell you that 2.0.40-rc8 seems to work really well, no
> problems compiling (except a few warnings :) and absolutely no problem
> running. Great work!

Most of the compile-time warning I got was from using a newer binutils,
but I'll try to fix all warnings (that are fixable without causing bugs)
in 2.0.41.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
