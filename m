Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTI2R6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTI2Ry3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:54:29 -0400
Received: from d014018.adsl.hansenet.de ([80.171.14.18]:48600 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264029AbTI2Rxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:53:54 -0400
Date: Mon, 29 Sep 2003 19:53:47 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: tom@qwws.net, Brandon Low <lostlogic@gentoo.org>, jbinpg@shaw.ca,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB-problem with uhci-hcd in versions 2.6.0-test5 and 2.6.0-test6
Message-ID: <20030929175347.GA1242@ppp0.net>
Mail-Followup-To: Wim Van Sebroeck <wim@iguana.be>, tom@qwws.net,
	Brandon Low <lostlogic@gentoo.org>, jbinpg@shaw.ca,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20030929191850.A21072@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929191850.A21072@infomag.infomag.iguana.be>
I-love-doing-this: really
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.4.22aa1 (i686)
X-Uptime: 19:41:08 up 1 day,  7:32,  7 users,  load average: 0.41, 0.41, 0.37
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Van Sebroeck <wim@iguana.be> wrote on 2003-09-29 19:18:50
> Hi All,
> 
> I saw that you also reported problems with USB/uhci-hcd on your systems. Can you test
> the following patch and see if it works now?
> 

This fixes it for me. Oops gone and interrupt up again :-)

Thanks,

   Jan

--
Jan Dittmer - jdittmer@ppp0.net
