Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbTFEWCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTFEWCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:02:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26873 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265218AbTFEWCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:02:17 -0400
Date: Fri, 6 Jun 2003 00:15:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: FW: Linux 2.4.20
Message-ID: <20030605221541.GG7431@fs.tum.de>
References: <000301c32ba6$6135ff00$1311a8c0@pitzeier.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c32ba6$6135ff00$1311a8c0@pitzeier.priv.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 11:06:48PM +0200, Oliver Pitzeier wrote:
> Hi folks!
> 
> Andreas de Pretis wrote:
> > das Documentation/DocBook/journal-api.tmpl hat nen Bug (mach 
> > mal ein 'make htmldocs') ... Patch ist anbei.
> 
> As German understading people can read above, Mr. Andreas de Pretis, sent me
> this patch to forward it to the lkml. The problem seems to be, that he was not
> able to do a 'make htmldocs', because of some (wrong) SGML tags in
> journal-api.tmpl.
> 
> Please have a look at it, patch is attached (simple, but working. :-) ).

This issue is already fixed in 2.4.21-rc7 .

> Best regards,
>  Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

