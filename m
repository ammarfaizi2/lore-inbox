Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVGBDUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVGBDUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 23:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVGBDUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 23:20:15 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:4085 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261753AbVGBDUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 23:20:09 -0400
Date: Sat, 2 Jul 2005 00:19:55 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Firewire/SBP2 and the -mm tree (was: Re: 2.6.13-rc1-mm1)
Message-ID: <20050702031955.GC28251@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050701044018.281b1ebd.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.

On Friday, 1 of July 2005 13:40, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/2.6.13-rc1-mm1/

Please, correct me if I am wrong, but this doesn't seem to include any
fixes for the SBP2 problems that I was seeing, right?

I generated a patch from Linus's 2.6.13-rc1 against the trunk of
linux1394.org's tree containing (as Ben Collins suggested), just the
differences on sbp2.[ch] and it applied without any problems (no skips, no
rejects, no nothing) in -rc1-mm1.

I have not tested -rc1-mm1 without the patch, but assuming that all other
things are equal regarding it, I need this patch for using Firewire on my
computer.

Is there any estimated possibility of including an update from the
linux1394 team in future versions of -mm or, even better, pushing them to
Linus's tree?


Thank you very much, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
