Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267606AbUBTATs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUBTATs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:19:48 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:39346 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S267606AbUBTAP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:15:27 -0500
Date: Fri, 20 Feb 2004 01:15:24 +0100
From: David Weinehall <tao@acc.umu.se>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.3-uc0 (MMU-less fixups)
Message-ID: <20040220001524.GL17140@khan.acc.umu.se>
Mail-Followup-To: Greg Ungerer <gerg@snapgear.com>,
	linux-kernel@vger.kernel.org
References: <40342BD5.9080105@snapgear.com> <20040219103900.GH17140@khan.acc.umu.se> <4034B2E5.1090505@snapgear.com> <20040219131317.GI17140@khan.acc.umu.se> <40355080.8090008@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40355080.8090008@snapgear.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 10:10:40AM +1000, Greg Ungerer wrote:
[snip]
> You don't need real hardware :-)
> 
> The gdb/ARMulator makes a fine target for development.
> Quicker and easier to develop with. Heres a good place
> to get started with it if interrested:
> 
>   http://www.uclinux.org/pub/uClinux/utilities/armulator/

Yeah, but real hardware is more fun.

> >How's the status of the 2.0-port of uClinux, btw?  Is it unintrusive
> >enough to be considered for a 2.0-merge?
> 
> Hmm, probably not. It is no where near as clean as the 2.6
> merge. It could be cleaned up, but no one seems to interrested
> in doing the work.

Well, if there are users and interest, I could do at least some of the
work.  Since I've already done some work with 2.0 uClinux, and since I'm
the 2.0 maintainer, I do have some experience ;-)


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
