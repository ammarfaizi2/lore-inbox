Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271260AbRHOQQh>; Wed, 15 Aug 2001 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271262AbRHOQQ1>; Wed, 15 Aug 2001 12:16:27 -0400
Received: from ns.muni.cz ([147.251.4.33]:21422 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S271260AbRHOQQR>;
	Wed, 15 Aug 2001 12:16:17 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Spinlock for accessing graphical hardware (G400)
Message-ID: <3B7AA05A.46C8EC03@i.am>
Date: Wed, 15 Aug 2001 16:16:26 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-pre7-RTL3.0 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I would like to know if there is any way, how could I create my own
driver for
the graphics card (G400) - I mean there are XFree, DRM, mga conscole 
and I want
to se my own driver - but I really need something like  common lock for
accessing
hardware registers.

Is there any way how one could one achieve such thing on SMP machine ?
Does anyone plan to add such thing ?
(I do not want to add my driver to Drm nor to console device)

thanks

kabi

