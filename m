Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310306AbSCBEL1>; Fri, 1 Mar 2002 23:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310309AbSCBELQ>; Fri, 1 Mar 2002 23:11:16 -0500
Received: from cdserv.meridian-data.com ([206.79.177.152]:54286 "EHLO
	nasexs1.meridian-data.com") by vger.kernel.org with ESMTP
	id <S310306AbSCBELA>; Fri, 1 Mar 2002 23:11:00 -0500
Message-ID: <2D0AFEFEE711D611923E009027D39F2B153ADF@cdserv.meridian-data.com>
From: "Dennis, Jim" <jdennis@snapserver.com>
To: "'Stephen Degler'" <sdegler@degler.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Congrats Marcelo,
Date: Fri, 1 Mar 2002 20:13:37 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Stephen.  Seen M lately?

> Hi,

> FYI crypto is included in (Net|Free|Open)BSD source releases and I don't
> believe it is an issue for them.

> skd

 OpenBSD is maintained in Canada.  IIRC the FreeBSD IPSec patches started in

 Japan, but I guess they have been merged into the mainstream.  I don't know
 about NetBSD.

 However, the point is well taken.  If our *BSD freeware OS' have been
successfully
 shipping with IPSec and other advanced crypto, from the U.S. outbound than
it's a
 precedent we may be able to follow.  Also the Debian project seems to be
moving in 
 that direction (including crypto in their mainstream distro).  

 Obviously I opened a can of worms with my question.  I just wanted to know
when
 the unofficial patches would be sync with 2.4.18 (so I could fetch and
apply them
 without having to wrangle addition .rej files; since I a number of local
patches to 
 apply and wrangle *their* rejects is enough work already).

 Clearly there's alot of pent up demand to include more stuff in the
mainstream.  
 I can understand Marcelo's conservatism (and Linus').  So the various
branch trees
 that are popping up.  This latest one by Jorg Prante (sorry of the the lack
of 
 proper diacriticals) is a nice base, with XFS, rmap, Ingo's O(1) scheduler,
KLIPS
 and patch-int, and quite a few others.  It isn't as outrageous as FOLK and
it uses
 the GR (getrewted) patches rather than LIDS.  However, as I say, it's a
nice base
 for someone who wants to be a few steps off the mainstream.


> On Thu, Feb 28, 2002 at 06:52:25PM -0300, Marcelo Tosatti wrote:
> On Tue, 26 Feb 2002, Dennis, Jim wrote:
>> Marcelo,
>> 
>>  Contratulations on your first "official" kernel release.  It seems to
>> have gone
>>  well (except for some complaints on slashdot about -rc4 SPARC patches
>> missing from
>>  the patch, but apparently in the full tarball).
>> 
>>  Now I need to know about the status of several unofficial patches:
>> 
>> 	XFS
 
> Want to see stable in -ac first.
 
>> 	LVM
 
> Its on 2.4 already.
 
>> 	i2c
>> 	Crypto
>> 	FreeS/WAN KLIPS
>> 	LIDS
 
> I think its not possible to distribute crypto stuff in the stock kernel.
 
> Am I wrong? 
 
>> 	rmap
 
> I need to see it running in production for more time.
 
>>  Marcelo, there were some i2c updates included in the lmsensors package,
>> have they
>>  submitted those to you for integration into 2.4.19?
 
> Nope. I could well integrate lm_sensors in the future.
 
