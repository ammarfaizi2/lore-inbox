Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269683AbUJAEBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269683AbUJAEBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 00:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269687AbUJAEBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 00:01:50 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:19329 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S269683AbUJAEBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 00:01:46 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Fri, 1 Oct 2004 00:01:44 -0400
User-Agent: KMail/1.7
Cc: Clemens Schwaighofer <cs@tequila.co.jp>, Jeff Garzik <jgarzik@pobox.com>,
       "Markus T." <markus@trippelsdorf.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <200409302330.26396.gene.heskett@verizon.net> <415CD05F.4040305@tequila.co.jp>
In-Reply-To: <415CD05F.4040305@tequila.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410010001.44762.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 23:01:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 23:34, Clemens Schwaighofer wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On 10/01/2004 12:30 PM, Gene Heskett wrote:
>|> Beats me, Clemens.  But at the time, I got curious and the
>|> problem was 100% repeatable using the bz2 src code files I had. 
>|> The third time I went after the srcs and patches to build that
>|> kernel, I got the .gz versions of both, and they worked first
>|> time.  Then I went back to the .bz2's and was seeing the same
>|> problem as the first 2 downloads gave me.  I mv'd that src file &
>|> patch, went after the .bz2's again (for the 3rd time), and that
>|> time it worked flawlessly.  Both the 2nd and 3rd dl's files had
>|> the exact same md5sum too.  Go figure.
>
>have you unpacked the source and made a diff? is the source the same
>then? perhaps its something with CPU/RAM ? Ever thought of that. If
> only you have it, then what kind of libraries are you using,
> perhaps it some problem only on your box. Can you repeat that on
> other boxes, etc.
>
>|> bz2 problem?  DamnedifIknow.  snilmerg maybe?  But it goes away
>|> if I stick to the .gz's.
>
>It would be interesting to investigate this further. Because if bz2
> is not save to transport data, then you can't use it anymore.
>
I think my biggest concern was the fact that it didn't give any kind 
of an error message at the time.  That box is now my firewall, and 
has the latest up2dates installed until rh eol'd the 7.3 support.  
Running an old kernel 2.4.21-rc1-ck6 I built, it commonly gets quite 
boring uptimes.  I have a BIG ups, so its only prolonged outages that 
reset me.

Well, I was gonna brag, but 14 days isn't bragging materiel.  I 
rebooted it after seeing something I didn't like in the logs, a port 
scan for port 33377 or some such number, from an IP thats is a 
verizon nameserver.  How they got thru the router is beyond me.  The 
last time that happened, it hacked a 2 week old Seimans router into a 
light weight paper weight.  The linksys I have in there now seems to 
have survived, but is getting flakey, and Jim, the IT guy at the tv 
station tells me he had to get 3 of them in a week recently for his 
home system because they kept falling over.  When in the hell are 
they gonna put in the quality before the name goes on the box again?

That knocking sound?  That will be me pounding my head on the wall if 
this one pukes.

>- --
>[ Clemens Schwaighofer                      -----=====:::::~ ]
>[ TBWA\ && TEQUILA\ Japan IT Group                           ]
>[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
>[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
>[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
>iD8DBQFBXNBfjBz/yQjBxz8RAkLBAKCTFd4niu/StV85xloSuHmOowcOUgCdGTyI
>18/zlWp2oyfNz/jSJ7Zpjig=
>=iG6j
>-----END PGP SIGNATURE-----

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
