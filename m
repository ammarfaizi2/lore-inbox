Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbUKXIYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUKXIYe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUKXIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:22:55 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:12456 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262531AbUKXIVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:21:33 -0500
Date: Wed, 24 Nov 2004 08:59:32 +0100
From: David Weinehall <tao@acc.umu.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [2.6 patch] small MCA cleanups (fwd)
Message-ID: <20041124075932.GJ28432@khan.acc.umu.se>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
References: <20041124020427.GM2927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124020427.GM2927@stusta.de>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 03:04:27AM +0100, Adrian Bunk wrote:
> 
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm3.
> 
> Please apply.

Being waaaaaay to busy at work to care about MCA-related things anymore,
combined with the fact that I didn't bring along any of my old
MCA-machines when I moved the last time, I've asked James Bottomley to
take over the MCA maintainership.

I don't have anything to object against these patches, but I'm not able
to test them...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
