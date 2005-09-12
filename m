Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVILACq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVILACq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 20:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVILACq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 20:02:46 -0400
Received: from web53602.mail.yahoo.com ([206.190.37.35]:23996 "HELO
	web53602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751093AbVILACp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 20:02:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=svSmrc7uyWXpsvpcKLCnJNibXjns+SwuVJ0+1mEXvpVoVAnozZGtvTB3QhUBoDxnxH41wx95A6Hm477KSuymocjo8F8tWDqqDAtwH7ddz+zrfjTAn0mscjzwVUKoOeH6ya2iz2cv+Nq8vI4qDZj0M4zwvWaEiUOyuvjZZ8FkYOw=  ;
Message-ID: <20050912000234.44429.qmail@web53602.mail.yahoo.com>
Date: Mon, 12 Sep 2005 10:02:33 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Daniel Drake <dsd@gentoo.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Netdev List <netdev@vger.kernel.org>
In-Reply-To: <43244C33.1050502@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Steve, maybe you could test it out? I have attached
> it to this Gentoo bug:
> 
> 	http://bugs.gentoo.org/100258

Have tested it and it does *not* solve the problem for
me.

Besides lots of other problem with 2.6.13 for me, like
modem device not work, lots of extra modules not
compiled  (ov511 ; unionfs etc..) so even it works I
still need to revet back to 2.6.12.

Cheers,


S.KIEU

Send instant messages to your online friends http://au.messenger.yahoo.com 
