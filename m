Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319571AbSH3OL3>; Fri, 30 Aug 2002 10:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319572AbSH3OL3>; Fri, 30 Aug 2002 10:11:29 -0400
Received: from web20503.mail.yahoo.com ([216.136.226.138]:57940 "HELO
	web20503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319571AbSH3OL2>; Fri, 30 Aug 2002 10:11:28 -0400
Message-ID: <20020830141552.77480.qmail@web20503.mail.yahoo.com>
Date: Fri, 30 Aug 2002 16:15:52 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: bonding quits working properly after a short time
To: Sam James <sam.james@adelphia.com>, linux-kernel@vger.kernel.org
Cc: willy@meta-x.org
In-Reply-To: <69DCAE8DF2BFD411AACC0002A50A63F016BC7BAD@cdptex1.adelphiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have disabled the bonding for now.  This system 
> has been working fine without bonding for quite 
> some time with 2.4.14pre6 using eth0. 
 
since you've disabled bonding, have you tried 
both interfaces or only one of them ? eg: if 
your system works fine on the tulip, it may be 
the other one behaving badly. 
  
> also, in searching about this problem I read some 
> old messages about bonding being non SMP safe, 
> is that still true? this is a dual PPro 200 
> system. 
 
very old, it was one of the reasons I modified 
the driver a few years ago, and should be OK 
now. 
  
> P.S.  I didn't see anything in the MAINTAINERS 
> file on bonding but Willy's name seems to be 
> associated with the project so I cc'd him. 
 
well, I don't have much time to spend on this 
anymore, perhaps Chad Tindel has, but I doubt it. 
that's the reason why I nearly didn't work on 
the 2.4 port. But I still read reports, and 
sometimes reply :-) 
 
Cheers, 
Willy 


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
