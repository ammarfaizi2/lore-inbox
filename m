Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbRF3Jch>; Sat, 30 Jun 2001 05:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264881AbRF3Jc1>; Sat, 30 Jun 2001 05:32:27 -0400
Received: from web10402.mail.yahoo.com ([216.136.130.94]:529 "HELO
	web10402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264877AbRF3JcU>; Sat, 30 Jun 2001 05:32:20 -0400
Message-ID: <20010630093219.83012.qmail@web10402.mail.yahoo.com>
Date: Sat, 30 Jun 2001 19:32:19 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: More feature should be added into main kernel(Was: supermount)
To: John Silva <jps@aerizen.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B3D60FA.DA4FF634@aerizen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just my humble opinion, please dont laugh if I am
wrong, I think:

Supermount
JFS 

I use the patch from IBM ; now running JFS, and notice
a bit improved performance than Reiserfs, it is good
file system, (they release stable (may be?) release
already). But It is hard, they only give the patch for
the main version, say 2.4.x x< 5 and 2.4.5; I patch to
2.4.5 then apply the ac22 series, it spits errors,
then I had to patch manually but may be I made a
mistake somewhere, when compile it gave me errors, 
Okay some one may tell me to use FOLK, but I tried
last time, and failled to compile, ( I fogot the error
message sorry, ) so now I have to use 2.4.4 with JFS.

The same for supermount, the patch is only for 2.4.0,
but this time I am ok to manually patch it.


 --- John Silva <jps@aerizen.com> wrote: > Supermount
has been integrated into the Mandrake 8
> kernel (2.4);
> I have been unable to locate the standalone patch
> for this, however.
> 
> Steve Kieu wrote:
> > 
> >  --- Sam Halliday <10226982@qub.ac.uk> wrote: >
> This
> > email was delivered to you by The Free
> > > Internet,
> > > a Business Online Group company.
> > > http://www.thefreeinternet.net
> > I totally aggree, supermount is nice features and
> it
> > should be integrated into the main kernel stream
> (just
> > my HO)
> > 
> > >
> >
>
---------------------------------------------------------------
> > > hello,
> > >     i am fairly new to linux, i need it's fast
> > > number crunching powers
> > > for my research... and i have only recently
> begun to
> > > have a look at the
> > > kernel (i believe every workman should know his
> > > tools)..... but i have
> > > noticed that supermount is not a standard part
> of
> > > the project, is there
> > > any reason why this is? is it due to man power?
> i
> > > would have been less
> > > shocked by the absense of other features in the
> > >
> > 
> > > radio support, supermount seems to me to be
> > > essential in any operating
> > > system.....
> > >     i apologise if this is a very silly question
> or
> > > if i have posted
> > > this question in the wrong place, but please
> excuse
> > > me, im new to this
> > > whole world.
> > >
> > > and keep up the good work, i wish i knew more
> about
> > > the whole thing so i
> > > could contribute something.
> > >
> > > Sam, Ireland
> > >
> > > -
> > > To unsubscribe from this list: send the line
> > > "unsubscribe linux-kernel" in
> > > the body of a message to
> majordomo@vger.kernel.org
> > > More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > =====
> > S.KIEU
> > 
> >
>
_____________________________________________________________________________
> > http://messenger.yahoo.com.au - Yahoo! Messenger
> > - Voice chat, mail alerts, stock quotes and
> favourite news and lots more!
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> John P. Silva                           
jps@aerizen.com 

=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
