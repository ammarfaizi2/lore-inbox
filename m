Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279089AbRJVXal>; Mon, 22 Oct 2001 19:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279088AbRJVXad>; Mon, 22 Oct 2001 19:30:33 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:13075 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S279087AbRJVXaV>; Mon, 22 Oct 2001 19:30:21 -0400
Message-ID: <021a01c15b51$62958810$2a040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "David Weinehall" <tao@acc.umu.se>
Cc: "Dan Hollis" <goemon@anime.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Tudor Bosman" <tudorb@pikka.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0110221345131.17672-100000@anime.net> <017601c15b3e$51b12b70$2a040a0a@zeusinc.com> <20011023004947.U25701@khan.acc.umu.se>
Subject: Re: Linux 2.2.20pre10
Date: Mon, 22 Oct 2001 19:29:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not forgotten, just trying to understand relevance.  How do these cases,
> > which all revolve around breaking commercial products and cause damage
to
> > the corporations that push them, apply to security in the open source
Linux
> > kernel to which the public is given all rights.
>
> For me, DeCSS is an application that has a purpose for watching DVD:s
> when I boot my G4 into Linux instead of MacOS.

For me too, but in other people's opinion it's a tool for pirates (I don't
share this opinion, however, I can see how some people, who don't understand
the difference, might have this opinion).  However, I don't think that a
security exploit in an open sourced OS is likely to be a "curcumvention
device" to even clueless people.

> And even those that actually use DeCSS only to gain their "copyright"
> (that is, provide you with your right to copy what you have purchased,
> for backup-purposes, for instance) or indeed those that illegaly copy
> DVDs, seldom do so to break commercial products and cause damage to the
> corporations that push them.

Agreed, but's that's how these corporations (or coporate representatives)
managed to get these cases to court.  However, I fail to see who is going to
be the prosecutor in the case of a security exploit against the open source
Linux kernel.  In every one of these cases, DeCSS, SDI, and eBook, the
encryption that was hacked was put in place by the companies specifically to
protect the copyrighted work.  The Linux kernel provides general access
controls and does not meet the following DMCA requirement to be a copyright
protection system:

"(B) a technological measure "effectively controls access to a work" if the
measure, in the ordinary course of its operation, requires the application
of information, or a process or a treatment, with the authority of the
copyright owner, to gain access to the work."

The part that is missing is the "authority of the copyright owner" portion.
In the case of CSS, SDI, and eBook, the copyright owners all specifically
allow access to the information only when using authorized means of viewing
the work.  Last I checked no copyright owner has said that ACL's are an
authorized means.

This is my main argument why I think Alan is safe to post security related
information in changelogs.  I just don't think there is any way for someone
to interpret this law to mean that posting that information is illegal.  Of
course, if he still doesn't want to I respect that opinion as well, but I'm
sure willing to do it.

> As for the Sklyarov-case, I'm pretty sure he'd been arrested even if his
> program had been an open source program under the GPL, freely
> distributed etc.

I would tend to agree, because Adobe initially filed the complaint for
damages he could have been arrested under the civil action.  However, once
Adobe agreed to drop the issue (I'm not sure they did, but it is my
understanding that they have) it didn't matter much, because they are not
required to pursue the criminal portion, the government alone can pursue it
from there.

BTW, I'm not trying to argue that the cases which use the DMCA are valid in
any way, I'm totally againts all of them as they definately impose on my
fair use rights, which is why I have never purchased an eBook, don't own a
DVD player (actually not 100% true, I have a DVD player in my laptop and
have used it for loading software and playing around with DVD playback under
Linux using some borrowed DVD's), and don't own music with any SDI
watermarks (that I know of).  If companies don't want to grant me fair use,
I don't want their products.

Later,
Tom


