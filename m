Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265685AbUFDIiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265685AbUFDIiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 04:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFDIiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 04:38:54 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:12748 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265685AbUFDIiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 04:38:52 -0400
Date: Fri, 4 Jun 2004 10:38:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: Linux 2.4.27-pre5
Message-ID: <20040604083849.GA6493@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
References: <20040603022432.GA6039@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603022432.GA6039@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2004, Marcelo Tosatti wrote:

> Here goes -pre5.
> 
> This time we have merges from Jeff's -netdrivers tree, David's -net tree, 
> including a fix for compilation error without CONFIG_SCTP set, SPARC64 update,
> i810_audio fixes, amongst others.
> 
> 
> Summary of changes from v2.4.27-pre4 to v2.4.27-pre5
> ============================================
> 
> <chrisg:etnus.com>:
> <kevin.curtis:farsite.co.uk>:
> <pelle:dsv.su.se>:

Marcelo,

can you try to remember to "bk pull http://bktools.bkbits.net/bktools"
and "bk get shortlog" before sending out kernel changelogs? This will
resolve, for instance, all of the addresses in this particular
announcement to names.

BTW, if you forgot but haven't yet sent the announcement, perl shortlog
--mode=fixup will replace the addresses it knows (but it will not
re-sort the items).

Thanks.

Matthias
