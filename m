Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271912AbTGRVuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271911AbTGRVuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:50:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55767
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271912AbTGRVtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:49:02 -0400
Subject: Re: 2.4.22-pre6 deadlock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Gifford <maillist@jg555.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <courier.3F18518C.00003D85@server>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
	 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
	 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
	 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
	 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
	 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
	 <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c onectiva>
	 <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307171649340.2003@freak.distro.c onectiva>
	 <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307180925580.6642@freak.dis tro.conectiva>
	 <002e01c34d41$687dbe30$3400a8c0@W2RZ8L4S02>
	 <Pine.LNX.4.55L.0307181421550.7889@freak.distro.conectiva>
	 <courier.3F18518C.00003D85@server>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058565666.19511.93.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 23:01:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 20:59, Jim Gifford wrote:
> It is part of the antivirus program, information is available here. 
> 
> http://www.dazuko.org

What a fascinating little toy. This ties in with some interesting
desktop project stuff rather nicely (rememberance agents, live indexing)

However can you duplicate the hang without it loaded ?

