Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbRLTWks>; Thu, 20 Dec 2001 17:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286448AbRLTWkj>; Thu, 20 Dec 2001 17:40:39 -0500
Received: from pc26.tromso2.avidi.online.no ([148.122.16.26]:20497 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S286447AbRLTWk2>;
	Thu, 20 Dec 2001 17:40:28 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: "'David S. Miller'" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Scheduler ( was: Just a second ) ...
Date: Thu, 20 Dec 2001 23:40:23 +0100
Message-ID: <007401c189a7$50f6cd60$0300000a@samurai>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20011219.220151.56814481.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: David S. Miller
>   From: Linus Torvalds <torvalds@transmeta.com>
>   Well, that was true when the thing was written, but whether anybody
_uses_
>   it any more, I don't know. Tux gets the same effect on its own, and
I
>   don't know if Apache defaults to using sendfile or not.
>   
>Samba uses it by default, that I know for sure :-)

I wish... Neither Samba 2.2.2 nor the bleeding edge 3.0alpha11 includes
the word "sendfile" in the source at least. :( Wonder why the sendfile
patches where never merged...

--
Troels Walsted Hansen

