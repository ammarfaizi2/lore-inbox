Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUBLBTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUBLBTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:19:10 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:13586 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266448AbUBLBTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:19:07 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1076548709@astro.swin.edu.au>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
In-reply-to: <20040212004532.GB29952@hexapodia.org>
References: <20040209115852.GB877@schottelius.org> <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au> <1076517309.21961.169.camel@shaggy.austin.ibm.com> <20040212004532.GB29952@hexapodia.org>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-1003-6481-200402121218-tc@hexane.ssi.swin.edu.au>
Date: Thu, 12 Feb 2004 12:19:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> said on Wed, 11 Feb 2004 18:45:32 -0600:
> On Wed, Feb 11, 2004 at 10:35:10AM -0600, Dave Kleikamp wrote:
> > Yeah, JFS has poor default behavior based on CONFIG_NLS_DEFAULT.  I
> > attempted to explain why it works that way in the first bug listed above
> > if anyone is curious.
> 
> I think your suggested fix is good, but it begs the question:
> 
> Why on earth is JFS worried about the filename, anyways?  Why has it
> *ever* had *any* behavior other than "string of bytes, delimited with /,
> terminated with \0" ?

Thanks for wording my question better. That was *precisely* the
question I was trying to ask :)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Disclaimer: This post owned by the owner
