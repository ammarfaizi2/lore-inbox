Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUDUAia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUDUAia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbUDUAia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:38:30 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:16339
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S263807AbUDUAi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:38:28 -0400
Date: Tue, 20 Apr 2004 17:38:20 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040421003820.GB16901@tumblerings.org>
References: <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420172622.K22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 20, 2004 at 05:26:22PM -0700, Chris Wright wrote:
> * Zack Brown (zbrown@tumblerings.org) wrote:
> > for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
> > 2.5.8-pre2, as the full text of the changelog entry.
> 
> bk prs -r"davej@suse.de|ChangeSet|20020403195622" -hnd:REV: ChangeSet
> 
> That will give you the rev from that key in the Cset exclude message.

Will this give me the text of the changelog entry being reverted? That's
what I need to find.

Also, I'm not allowed to license BK. Is there some other way?

Many thanks,
Zack

> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown
