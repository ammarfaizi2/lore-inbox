Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUIWQMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUIWQMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIWQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:12:38 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:7312 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266477AbUIWQI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:08:58 -0400
Date: Thu, 23 Sep 2004 18:08:57 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, anton@samba.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Message-ID: <20040923160857.GB12071@MAIL.13thfloor.at>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Linas Vepstas <linas@austin.ibm.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, anton@samba.org,
	Andrew Morton <akpm@osdl.org>
References: <20040920221933.GB1872@austin.ibm.com> <20040920223121.GC1872@austin.ibm.com> <200409211407.09764.vda@port.imtp.ilyichevsk.odessa.ua> <20040921161216.GD1872@austin.ibm.com> <20040922231700.GE30109@MAIL.13thfloor.at> <16722.60814.732208.93234@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16722.60814.732208.93234@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 08:36:46AM -0700, Paul Mackerras wrote:
> Herbert Poetzl writes:
> 
> > well, I'd like to know if full whitespace cleanup
> > (trailing and indentation) _is_ something which
> > is interesting for linux mainline ...
> 
> It's like this... you get to clean up the white space in a file (if
> you want) IF you are also doing some useful work on the file - but the
> whitespace cleanup and the useful work need to be separate patches in
> order to ease later tracking of what changed.

ah, okay, so a larger patch cleaning up the
whitespace issues in let's say linux/kernel or
linux/fs would not be appreciated ...

thanks for the info,
Herbert

> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
