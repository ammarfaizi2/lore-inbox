Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUFCEgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUFCEgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUFCEgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:36:04 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:8129 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265499AbUFCEgB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:36:01 -0400
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de, Greg KH <greg@kroah.com>
In-Reply-To: <20040602213432.05f48058.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
	 <1086222156.29391.337.camel@bach>  <20040602213432.05f48058.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086237304.29391.406.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 14:35:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 14:34, Paul Jackson wrote:
> Rusty wrote:
> > Above all, by placing your questions inside a patch, you got results,
> > but please don't do this again.
> 
> Ah yes ...
> 
> Apparently, Rusty, you are unfamiliar with the style of coding that
> involves "put in an ugly hack now, commenting the known open issues,
> and then clean up the mess some other day".

Known open issues I have no problems with.  It's asking questions in the
comments that I disagree with: either you should ask on lkml, or grep.  

To be honest, if you can't figure out the answers, you have to ask if
you're the right person to be modifying the code.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

