Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbTCRKpC>; Tue, 18 Mar 2003 05:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbTCRKpC>; Tue, 18 Mar 2003 05:45:02 -0500
Received: from packet.digeo.com ([12.110.80.53]:59021 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262310AbTCRKpB>;
	Tue, 18 Mar 2003 05:45:01 -0500
Date: Tue, 18 Mar 2003 02:55:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Shawn <core@enodev.com>
Cc: ttsig@tuxyturvy.com, linux-kernel@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.5.64-mm8 breaks MASQ
Message-Id: <20030318025523.7360f1d9.akpm@digeo.com>
In-Reply-To: <1047984726.3914.2.camel@localhost.localdomain>
References: <1047922184.3223.2.camel@iso-8590-lx.zeusinc.com>
	<1047984726.3914.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2003 10:55:13.0841 (UTC) FILETIME=[DA705210:01C2ED3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> This actually broke in -mm7, but I don't know what causes it.
> 
> I have to admit, I haven't even looked at the patch to see what changed.
> Oh well, I suspect good ol' 65-mm1 will fix things up. If so, my TiVo
> could stop holding it's breath. ;)
> 
> Anyone else seeing this?

Stephen is looking into it.  Please send him your iptables
configuration info. 

