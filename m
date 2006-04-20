Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDTBG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDTBG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 21:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWDTBG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 21:06:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53254 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750712AbWDTBGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 21:06:25 -0400
Date: Thu, 20 Apr 2006 03:06:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org,
       greg@kroah.com, hch@infradead.org
Subject: Re: [RFC PATCH 1/2] Makefile: export-symbol usage report generator.
Message-ID: <20060420010624.GJ25047@stusta.de>
References: <20060413123826.52D94470030@localhost> <20060418140927.GB11582@stusta.de> <1145489158.7323.169.camel@localhost> <20060419234112.GI25047@stusta.de> <1145494414.7323.178.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145494414.7323.178.camel@localhost>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 05:53:34PM -0700, Ram Pai wrote:
> On Thu, 2006-04-20 at 01:41 +0200, Adrian Bunk wrote:
> > 
> > - it's a tool for kernel hackers who know what they are doing
> > - it's a tool to help you finding unused exports, but each one still
> >   requires manual verification
> 
> I am not sure I understand you.  Are you saying:
> 
>         A) the tool should report the export symbol usage with whatever
> 		set of modules the user has configured in his .config ?
> 		
> 		or
> 
>         B) the tool should report the export symbol usage for all the
> 	    modules irrespective of what has been configured in the
> 	    users .config ?

A)

> RP

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

