Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWHRQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWHRQqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWHRQqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:46:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52374 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751419AbWHRQqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:46:35 -0400
Subject: Re: /dev/sd*
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>,
       Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
	 <1155160903.5729.263.camel@localhost.localdomain>
	 <20060809221857.GG3691@stusta.de>
	 <20060810123643.GC25187@boogie.lpds.sztaki.hu>
	 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
	 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr>
	 <44E42900.1030905@PicturesInMotion.net>
	 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr>
	 <44E56804.1080906@bfh.ch>
	 <Pine.LNX.4.61.0608181050490.27740@yvahk01.tjqt.qr>
	 <1155913072.28764.3.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0608181748280.11320@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 12:47:18 -0400
Message-Id: <1155919638.24907.54.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 17:51 +0200, Jan Engelhardt wrote:
> >> Umm, hdx or sdx is a small impact. The real power of /dev/disk is that 
> >> not-so-technically minded users can go looking for their disk by its name 
> >
> >They already can. It appears on their desktop with a little picture that
> >says "My iSpod" or similar 8)
> 
> Not everyone follows Linus's "suggestion" to use KDE. Actually, there are 
> even people not thrilled by either KDE or GNOME.

It works the same way in Gnome (and any reasonable desktop OS).  If
users really don't want an integrated desktop environment I think they
get to figure out the disk naming issues themselves.

Lee

