Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbTCUSGp>; Fri, 21 Mar 2003 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTCUSGo>; Fri, 21 Mar 2003 13:06:44 -0500
Received: from tag.witbe.net ([81.88.96.48]:38663 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262583AbTCUSFz>;
	Fri, 21 Mar 2003 13:05:55 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>, "'Bill Davidsen'" <davidsen@tmr.com>
Cc: <root@oddball.prodigy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.64] X unlock doesn't work
Date: Fri, 21 Mar 2003 19:15:53 +0100
Message-ID: <00c701c2efd5$e920f940$6100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030321082705.23e3d70c.rddunlap@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to play with pwconv and pwunconv.... It worked for me though
I really *can't* explain why...

Paul


> | Now there's a new one... I just noticed that in my 2.5.64 
> kernel, when 
> | my
> | screensaver comes up and asks for a password to unlock, no 
> matter what 
> | password I give it is rejected. With 2.5.59 passwords work 
> for the user 
> | logged in.
> | 
> | Redhat 7.3, GNOME.
> | 
> | I just noticed because this is the first time since 2.5.64 came out 
> | that I
> | did anything from console, since it's a mail machine, stats 
> collector, 
> | etc.
> | 
> | I'll try 2.5.65 next week when I have more time.
> | --
> 
> I've had this problem for several weeks now, but I had (have) 
> no idea where the problem is.
> 
> Different distro, different desktop manager.

