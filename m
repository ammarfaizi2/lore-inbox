Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUBWOVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBWOVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:21:25 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:42633 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261865AbUBWOVX (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:21:23 -0500
Date: Mon, 23 Feb 2004 15:21:20 +0100
From: David Weinehall <tao@debian.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: alan@lxorguk.ukuu.org.uk, Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] Fix GDT limit in setup.S for 2.0 and 2.2
Message-ID: <20040223142120.GU17140@khan.acc.umu.se>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	alan@lxorguk.ukuu.org.uk, Linux-Kernel@vger.kernel.org
References: <403114D9.2060402@lovecn.org> <403A07D8.5050704@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403A07D8.5050704@greatcn.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 10:02:00PM +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> I posted this problem days ago. Just now I check FreeBSD code and find 
> theirs code goes no this problem. Please take my patches for 2.0 and 2.2
> 2.4 patch have been already sent to Anvin.
> 
> (patches for 2.0 and 2.2 enclosed)

Thanks.  Note that I'm not due to release the first pre-patch for 2.0.41
in another couple of months (unless some security issue surfaces)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
