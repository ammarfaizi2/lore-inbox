Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbWAGVu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbWAGVu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbWAGVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:50:58 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:20375 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1030601AbWAGVu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:50:57 -0500
Message-ID: <43C037B8.8080401@ens-lyon.org>
Date: Sat, 07 Jan 2006 16:50:48 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <20060107214208.GR9402@redhat.com>
In-Reply-To: <20060107214208.GR9402@redhat.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> > Should I prevent my initscript from loading agpgart (actually intel_agp)
> > at all ? (I guess udev or hotplug is trying to load it here). Is there
> > something like agpgart for PCI express ? Or is it useless ?
>
>it's useless. though the loading of it shouldn't harm anything.
>Does it spew warnings during your boot ?
>  
>
No, I don't see any warning/problem.

Thanks.
Brice

