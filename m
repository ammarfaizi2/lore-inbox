Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292871AbSCJHXB>; Sun, 10 Mar 2002 02:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSCJHWm>; Sun, 10 Mar 2002 02:22:42 -0500
Received: from mtao3.east.cox.net ([68.1.17.242]:28588 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP
	id <S292871AbSCJHWk>; Sun, 10 Mar 2002 02:22:40 -0500
Reply-To: <charles-heselton@cox.net>
From: "Charles Heselton" <charles-heselton@cox.net>
To: "Hua Zhong" <hzhong@cisco.com>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.5.6 Interactive performance
Date: Sat, 9 Mar 2002 23:23:10 -0800
Message-ID: <NFBBKFIFGLNJKLMMGGFPEEPICFAA.charles-heselton@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <003301c1c7fd$a67d08f0$bb187143@amer.cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can understand that.  This just seemed the most readily available
resource.  All of you über-geeks out there...I appreciate your knowledge and
hard work.

Thanks,
Charles Heselton
Network Installer
Staffing Alternatives, Inc.
619.261.6866
charles_heselton@hotmail.com <mailto:charles_heselton@hotmail.com>


-----Original Message-----
From: Hua Zhong [mailto:hzhong@cisco.com]
Sent: Saturday, March 09, 2002 2235
To: charles-heselton@cox.net
Subject: Re: Kernel 2.5.6 Interactive performance


I suggest you subsribe to the kernelnewbies maillist instead. Start from
http://www.kernelnewbies.org.
It's much more useful for a newbie.

LKML is for developing linux kernel, not for tutoring how to use kernel.
Don't expect/ask those hackers
to speak in language easy to understand for everyone.

----- Original Message -----
From: "Charles Heselton" <charles-heselton@cox.net>
To: "Robert Love" <rml@tech9.net>; "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Dieter N?tzel" <Dieter.Nuetzel@hamburg.de>; "Dan Mann"
<mainlylinux@attbi.com>; "Linux Kernel List" <linux-kernel@vger.kernel.org>;
"J.A. Magallon" <jamagallon@able.es>
Sent: Saturday, March 09, 2002 10:18 PM
Subject: RE: Kernel 2.5.6 Interactive performance


>
> Well, unfortunately, you guys are still talking a little above my head.  I
> kind of understand what you are saying but not completely.  Are the -aa
> and -ac patches?  How do you install/run a patch?  Are they tags to put in
> when compiling?  What is VM28-vm30?  All I've done so far is untar the
> tarballs from kernel.org (or wherever) and go from there.  Finally started
> having success with it, but all this stuff that you guys are talking about
> on the development level is a little above me.  Which, BTW, is partly why
I
> subscribed to the mailing list - to try to learn a little more.  So could
> you guys be a little more specific in the explanations?
>
> Thanks,
> Charles Heselton
> Network Installer
> Staffing Alternatives, Inc.
> 619.261.6866
> charles_heselton@hotmail.com <mailto:charles_heselton@hotmail.com>
>
>
>
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Robert Love
> Sent: Saturday, March 09, 2002 2206
> To: Mike Fedyk
> Cc: charles-heselton@cox.net; Dieter N?tzel; Dan Mann; Linux Kernel
> List; J.A. Magallon
> Subject: Re: Kernel 2.5.6 Interactive performance
>
>
> On Sat, 2002-03-09 at 23:38, Mike Fedyk wrote:
>
> > On Sat, Mar 09, 2002 at 11:23:48PM -0500, Robert Love wrote:
> > > The 2.5 tree also has most of these toys, and is a better place for
this
> > > development IMO.  Personally, I'd stay away from these all-in-one
silly
> > > patches that are floating around these days.  Your safest bet is just
> > > stock 2.4.18 or whatever is latest, although the above addons are all
at
> > > varying levels of "stable" and "safe".
> > >
> >
> > Then what do you call -aa and -ac? ;)
> >
> > These "all-in-one" patches do make it harder to debug specific patches,
> but
> > it does create a wider audience for many patches that wouldn't be used
> > otherwise.
>
> I don't put -aa nor -ac in the same category as what I refer to above.
> Alan and Andrea's trees both contain an intelligent combination of
> useful patches, bug fixes, and code from Alan and Andrea themselves.
>
> The plethora of all-in-one every-patch-under-the-sun patchsets don't
> fall into the above category, in my opinion.  They just mix various new
> feature patches.  They do offer one benefit: much wider exposure for
> some potentially very useful patches.  I have found, however, that they
> don't help the actual patch authors much since (a) they are mixed in
> with many other patches and possibly even erroneously merged and (b) the
> bug reports never make it upstream to the actual patch maintainers.
>
> Maybe I'm just annoyed by the even greater signal-to-noise ratio on lkml
> :-)
>
> Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


