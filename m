Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSFMWTd>; Thu, 13 Jun 2002 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSFMWTc>; Thu, 13 Jun 2002 18:19:32 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54975 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317590AbSFMWTb>; Thu, 13 Jun 2002 18:19:31 -0400
Date: Thu, 13 Jun 2002 15:18:55 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>
cc: Keith Owens <kaos@ocs.com.au>, Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>,
        linux-kernel@vger.kernel.org, xsdg <xsdg@openprojects.net>
Subject: Re: [patch] early printk. (was: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs)
Message-ID: <55490000.1024006734@flay>
In-Reply-To: <20020612172754.C87@toy.ucw.cz>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> you might as well try the attached early_printk() patch, it's slightly
>> easier to use than a one-char macro. But the goal is the same.
> 
> Could this be arch-independend? x86-64 has it, too, and AFAIR it was taken
> from ia64.. Plus, it is *very* usefull.

We already did a generic version and submitted it - look back for
posts by Keith Mannthey. If you can't locate it, let me know, and I'll
dig it out.

Martin.

