Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbULOQRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbULOQRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbULOQRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:17:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:65466 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262376AbULOQRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:17:14 -0500
Subject: Re: 2.6.10-rc3-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: rol@as2917.net
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200412151041.iBFAfea07825@tag.witbe.net>
References: <200412151041.iBFAfea07825@tag.witbe.net>
Content-Type: text/plain
Message-Id: <1103127403.4145.0.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 15 Dec 2004 08:16:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The allnoconfig bzImage build should be 0 warnings, 0 errors.

On Wed, 2004-12-15 at 02:41, Paul Rolland wrote:
> Hello,
> 
> > Kernel            bzImage   bzImage  bzImage  modules  
> > bzImage  modules
> >                 (defconfig) (allno) (allyes) (allyes) 
> > (allmod) (allmod)
> > --------------- ---------- -------- -------- -------- 
> > -------- --------
> > 2.6.10-rc3-mm1   12w/0e     1w/7e   414w/0e    6w/0e  16w/0e  
> >   401w/0e
> 
> Web site says 0w/0e for bzImage(allno).
> 
> Which one is correct ?
> 
> Regards,
> Paul
-- 
John Cherry
cherry@osdl.org
503-626-2455x29
Open Source Development Labs

