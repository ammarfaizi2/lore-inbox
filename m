Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUGSKCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUGSKCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGSKCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:02:06 -0400
Received: from burro.logi-track.com ([213.239.193.212]:33683 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S264929AbUGSKCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:02:02 -0400
Date: Mon, 19 Jul 2004 12:02:00 +0200
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CCISS Maintainers Contact?
Message-Id: <20040719120200.1428521e@kingfisher.intern.logi-track.com>
In-Reply-To: <20040717113711.17e36586.akpm@osdl.org>
References: <20040716141809.21fabff9@kingfisher.intern.logi-track.com>
	<20040717113711.17e36586.akpm@osdl.org>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 17 Jul 2004 11:37:11 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Markus Schaber <schabios@logi-track.com> wrote:
> >
> > Regarding my caching problems mentioned some days ago, I recently
> > tried to contact the CCISS driver maintainers, but it seems that all
> > the mail addresses mentioned in the source are dead, and they did
> > not read this list (or all of them are on a long holiday which might
> > as well be possible).
> > 
> > Do you know any reliable way to contact them?
> 
> Try mikem@beardog.cca.cpqcorp.net

Thanks, he already contacted me himself.

It seems that the maintainer information in the driver files is somehow
outdated, and I'm to stupid to correctly read the MAINTAINERS file
('grep -i cciss MAINTAINERS' does not work as the driver is listed as
'HEWLETT-PACKARD SMART CISS RAID DRIVER' there...)

Thanks for your help,
Markus Schaber
-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
