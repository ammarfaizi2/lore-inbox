Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVJDOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVJDOMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVJDOMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:12:05 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.4.202]:16775 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932469AbVJDOME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:12:04 -0400
Date: Tue, 04 Oct 2005 10:11:52 -0400
From: Mathieu Chouquet-Stringer <ml2news@optonline.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: Linux 2.6.13.3 (inconsistent KALLSYMS)
In-reply-to: <43428D0B.5000205@grupopie.com>
To: pmarques@grupopie.com (Paulo Marques)
Cc: Mathieu Chouquet-Stringer <ml2news@optonline.net>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <m3psqljrrr.fsf@mcs.bigip.mine.nu>
Organization: Uh?
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
References: <20051004011620.GO16352@shell0.pdx.osdl.net>
 <43428D0B.5000205@grupopie.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pmarques@grupopie.com (Paulo Marques) writes:
> Mathieu Chouquet-Stringer wrote:
> > chrisw@osdl.org (Chris Wright) writes:
> >
> >>We (the -stable team) are announcing the release of the 2.6.13.3 kernel.
> >>[...]
> > With the attached configuration [1], I get the following error:
> > Inconsistent kallsyms data
> > Try setting CONFIG_KALLSYMS_EXTRA_PASS
> 
> This is probably a known problem that is already fixed in 2.6.14 :(
> 
> The attached patch should fix it for you.

Thanks Paulo, I'm giving it a shot, will keep you posted...
 
-- 
Mathieu Chouquet-Stringer
    "Le disparu, si l'on vénère sa mémoire, est plus présent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exupéry, Citadelle --
