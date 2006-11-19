Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755147AbWKSBVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbWKSBVb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 20:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbWKSBVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 20:21:31 -0500
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:34223 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1755147AbWKSBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 20:21:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:X-YMail-OSG:From:Organization:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=l1IcT5aGugqm8re7WqBIfYmvu7kaal5b++z871IpqwO5p/yA71mv9bnFiD1A+FBgf6t8nc1R7oWFjHueUgY8+fK2cR1qXRqNX8JByAaV71N7xef5OR5Z8KNd/vetV8XqdYG5RNgEg5CasR7z8ikZg85u0DC0u5kD/sfgDJ8QuT0=  ;
X-YMail-OSG: KtBLczQVM1nuYY5nZBssAazWfd3FoFLyeT0Uz_buuJ.GHRffOAfwnkEM9U.QG5wl2kMu74ZIScn9qw7kV6H2KJl7bsvMTQAyW77gQ37eTruPitkR78ftBA--
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues
Date: Sat, 18 Nov 2006 20:21:25 -0500
User-Agent: KMail/1.9.5
Cc: "Mark Lord" <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <20061113164025.78522.qmail@web88002.mail.re2.yahoo.com> <4558B309.2070708@rtr.ca> <5a4c581d0611140432j7626c175q4d09ade97f07d865@mail.gmail.com>
In-Reply-To: <5a4c581d0611140432j7626c175q4d09ade97f07d865@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611182021.26486.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 7:32 am, Alessandro Suardi wrote:
> On 11/13/06, Mark Lord <lkml@rtr.ca> wrote:
> > Shawn Starr wrote:
> > > With WPA2? I have to confirm if things are still broken with ipw2200
> > > 1.1.4. I wish this was sorted out. Really, the developers seem to have
> > > vanished afaik.
> >
> > I'm using WPA2 CCMP+CCMP(AES) with 2.6.18.  No problems.
>
> WPA1+TKIP in my case.
>
> --alessandro
>
> "...when I get it, I _get_ it"
>
>      (Lara Eidemiller)

Looks good, 2.6.19-rc6 seems ok. I dont need to download the tarballs now 
since the version is now 1.1.4 vs 1.1.2 in ipw2200.sf.net.  

Shawn.
