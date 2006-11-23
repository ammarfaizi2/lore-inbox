Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933601AbWKWL00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbWKWL00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbWKWL00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:26:26 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:15033 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S933601AbWKWL0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:26:25 -0500
Date: Thu, 23 Nov 2006 12:26:11 +0100
From: The Peach <smartart@tiscali.it>
To: DervishD <lkml@dervishd.net>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: bug? VFAT copy problem
Message-ID: <20061123122611.60a8fd7c@localhost>
In-Reply-To: <20061123091301.GC21908@DervishD>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<1164204175.10427.1.camel@localhost.localdomain>
	<20061122145344.GB18141@DervishD>
	<1164243385.3525.19.camel@monteirov>
	<20061123091301.GC21908@DervishD>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 10:13:01 +0100
DervishD <lkml@dervishd.net> wrote:

> > Have you a solution for the case ? Now I have the file in ext3 and
> > I couldn't copy to any vfat :)
> 
>     No, I don't have any idea about how to do it, sorry :(
> 

maybe using ntfs-3g driver with fuse or use the extX windows driver (if the need was read from Windows).
I'm feeling quite confortable with the first solution, whilst the second is suggested by the official linux ntfs support page

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
