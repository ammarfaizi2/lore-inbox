Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFEWdU>; Wed, 5 Jun 2002 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316496AbSFEWdT>; Wed, 5 Jun 2002 18:33:19 -0400
Received: from p508EB45E.dip.t-dialin.net ([80.142.180.94]:6663 "EHLO
	wilmskamp.dyndns.org") by vger.kernel.org with ESMTP
	id <S316491AbSFEWdQ> convert rfc822-to-8bit; Wed, 5 Jun 2002 18:33:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Wegner <oliver@wilmskamp.dyndns.org>
To: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
Date: Thu, 6 Jun 2002 00:33:16 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <Pine.LNX.3.95.1020605172819.12226A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206060033.16700.oliver@wilmskamp.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2002 23:37 schrieb Richard B. Johnson:
> On Wed, 5 Jun 2002, Oliver Wegner wrote:
> > Am Mittwoch, 5. Juni 2002 21:08 schrieb Eric Kristopher Sandall:
> > > On Wed, 5 Jun 2002, John Tyner wrote:
> > > > > Just put the module name in /etc/modules
> > > >
> > > > This is distribution dependent isn't it?
> > >
> > > afaik, it is not distro dependent.  I've used /etc/modules in
> > > RedHat, Debian, Sorcery, Source Mage, and Mandrake, all to the same
> > > effect.
> >
> > well, i havent found that file /etc/modules in SuSE. am not aware
> > right now how they handle loading modules during boot process... ;)
> >
> > Oliver


> [...] You need to know that Linux uses a strange command
> interpreter that, unlike windows, does not know how to read one's
> mind.
i never asked linux to read my mind and i know about the differences 
between windows and linux. i appreciate that linux doesnt try to do 
everything automatically. thats one reason why i use linux ;)

> This means that, should you enter, for instance, `ls
> /etc/modules`, it isn't going to find it because it doesn't exist. You
> need to either type its full name or use wild-cards which I won't
> explain here.
i am aware of all that of course, i think everybody who reads this 
mailinglist knows how to handle shell commands and wildcards so i wonder 
why you mention it here though. maybe you should consider writing a book 
for linux beginners ;)


Oliver

