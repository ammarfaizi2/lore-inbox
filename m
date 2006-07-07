Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWGGV46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWGGV46 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWGGV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:56:58 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:40197 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932329AbWGGV45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:56:57 -0400
Date: Fri, 7 Jul 2006 23:56:57 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707215656.GA30353@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, grundig <grundig@teleline.es>,
	Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
	linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com> <20060707180310.ef7186d7.grundig@teleline.es> <20060707174424.GA9913@dspnet.fr.eu.org> <20060707213916.GC5393@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707213916.GC5393@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 09:39:17PM +0000, Pavel Machek wrote:
> ...which is already merged in 2.6.17, BTW.

Sure.  It's a stupid approach, but since you have your name in the
MAINTAINERS file, you don't have to care.  Meanwhile, those who would
like a reliable suspend are out of luck.


> So what Pavel wants can be
> translated as 'please use already merged code, it can already do what
> you want without further changing kernel'.

Like we'd want to use unreviewed, extremely new and risky code for
something that happily destroy filesystems.

  OG.
