Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUA3NmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 08:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUA3NmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 08:42:15 -0500
Received: from wallaby.dingens.org ([213.133.123.121]:23175 "EHLO
	uml3.dingens.org") by vger.kernel.org with ESMTP id S263850AbUA3NmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 08:42:14 -0500
Date: Fri, 30 Jan 2004 14:42:00 +0100
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors with USB Disk
Message-Id: <20040130144200.56246879.schabios@logi-track.com>
In-Reply-To: <20040130.11444335@knigge.local.net>
References: <20040130122324.7ac7ef34.schabios@logi-track.com>
	<20040130.11444335@knigge.local.net>
Organization: Logi-Track AG, =?ISO-8859-15?Q?Z=FCrich?=
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

On Fri, 30 Jan 2004 11:44:43 GMT
Michael Knigge <Michael.Knigge@set-software.de> wrote:

> > I'm trying to use an USB Disk (IDE Disk in external USB Case), but
> > strange file system errors occurend and tools as dosfsck
> > reproducably hang.
> 
> Try/Read this:
> 
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg
> 18528.html
> 
> On my System, changing max_sectors to 128 doesn't help reliably. I'm 
> currently testing if 64/32/16/8 will work better.

Thanks a log, we'll try this on our machines.

Yours,
Markus
-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schaber@logi-track.com | www.logi-track.com
