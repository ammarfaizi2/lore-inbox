Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSH0W60>; Tue, 27 Aug 2002 18:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSH0W60>; Tue, 27 Aug 2002 18:58:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317349AbSH0W6Z>;
	Tue, 27 Aug 2002 18:58:25 -0400
Message-Id: <200208272302.g7RN2ZN18550@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: conman@kolivas.net
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: VM changes added to performance patches for 2.4.19 
In-Reply-To: Message from conman@kolivas.net 
   of "Sun, 25 Aug 2002 00:36:49 +1000." <1030199809.3d679a012042b@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Aug 2002 16:02:35 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quoting Daniel Phillips <phillips@arcor.de>:
> > Would you be so kind as to attempt to quantify that?
> 
> Ummm... I'm not sure if you're making fun or me? I haven't done any objective
> tests so I can't quantify it ??
> 
> I just found the responsiveness of the machine a little better and don't have
> the resources, time or inclination to test it with a benchmark. It's my
> understanding that the -aa patch performed better on benchmarks, but that some
> people reported the responsiveness was better with -rmap anyway. I'd agree with
> the latter statement. I offer both patches with mine so if people want to try my
> patch and feel strongly either way they can choose. My aim is to optimise system
> response for single cpu desktops, not multi cpu servers.
> 
> Con.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Con, 
Thanks for the work, and nice web page!
To help with the testing, i have taken the liberty of adding your 2.4.19-ck3 
patch to the OSDL's Patch
LifeCycle Manager. It's patch # 768. I've queued up a couple of the basic 
tests against it, (dbench, dbt1 )
If you want to add future versions and get some testing run, see 
http://osdl.org/cgi-bin/plm - it's really easy,
and you can use OSDL to make up for your lack of hardware.  We do focus more 
on multi-cpu systems, but
we're always interested in scheduler tests.

cliffw




