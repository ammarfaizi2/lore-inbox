Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbSIPP6T>; Mon, 16 Sep 2002 11:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbSIPP6S>; Mon, 16 Sep 2002 11:58:18 -0400
Received: from ns.sysgo.de ([213.68.67.98]:21497 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S262654AbSIPP6Q>;
	Mon, 16 Sep 2002 11:58:16 -0400
Date: Mon, 16 Sep 2002 17:59:41 +0200
From: Soewono Effendi <SEffendi@sysgo.de>
To: "Daniel Phillips" <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: kernel debuggers was [Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34]
Message-Id: <20020916175941.38927715.SEffendi@sysgo.de>
In-Reply-To: <E17qxbC-0000JO-00@starship>
References: <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com>
	<E17qejV-00008L-00@starship>
	<20020916090616.GF12364@suse.de>
	<E17qxbC-0000JO-00@starship>
Organization: SYSGO Real-Time Solutions GmbH
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just my .02 $

what I mostly admire in linux and it's development till now, 
is it's flexibility to adapt the dynamic complex changing requirements 
from server to desktop even embedded system and real-time system.
>From high throughput to low latency, you just name it!

And still though no one feels disadvantaged, 
since features not needed are "removable".

I'm just wondering "if it's worth the effort" to provide 
"removable customizable kernel debugging tools (entry/break points)", 
which one can replaces with tools of his/her choice.
I'm talking about some unified cleaver reasonable MACROS, 
which one can easy insert/use them where needed.

It's still wrong to force development tools to be persist in running system
where they are not needed.

There are lots of "nice things" that can be implemented in kernel, 
but are they essential?
Tools should not become burdens!

Best regards,
S. Effendi
