Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWGGRo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWGGRo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGGRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:44:26 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:9483 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932236AbWGGRoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:44:25 -0400
Date: Fri, 7 Jul 2006 19:44:24 +0200
From: Olivier Galibert <galibert@pobox.com>
To: grundig <grundig@teleline.es>
Cc: Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707174424.GA9913@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
	jan@rychter.com, linux-kernel@vger.kernel.org,
	suspend2-devel@lists.suspend2.net
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com> <20060707180310.ef7186d7.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707180310.ef7186d7.grundig@teleline.es>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 06:09:39PM +0200, grundig wrote:
> You may ask "why not merge suspend2", but from an objective
> POV it's perfectly fine that some people asks "why don't
> suspend2 people try to improve swsusp instead of rewritting
> it? It may be easier to fix swsusp than replacint it with
> suspend2"

Suspend2 is an improvement on swsusp.  What Pavel wants is something
completely different and even less tested that suspend2 called
uswsusp.

  OG.

