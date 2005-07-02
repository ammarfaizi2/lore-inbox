Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVGBEen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVGBEen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 00:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVGBEen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 00:34:43 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:2808 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261788AbVGBEek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 00:34:40 -0400
Date: Sat, 2 Jul 2005 01:34:37 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire/SBP2 and the -mm tree (was: Re: 2.6.13-rc1-mm1)
Message-ID: <20050702043435.GA4879@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050702031955.GC28251@ime.usp.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 02 2005, Rogério Brito wrote:
> I have not tested -rc1-mm1 without the patch, but assuming that all other
> things are equal regarding it, I need this patch for using Firewire on my
> computer.

Now, I have tested the -rc1-mm1 and things got worse: it doesn't matter if
I use plain -rc1-mm1 or if I modify sbp2.[ch]. The result is that I can't
see my Firewire drive.

Going to 2.6.13-rc1 with the modification to sbp2.[ch] seems to make the
drive work fine (that's what I am using in this exact moment).


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
