Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWC2DqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWC2DqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC2DqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:46:20 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:10667 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750742AbWC2DqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:46:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MOxds61XO8Sj6IUkeefhInsEV52/vIsq1HfB29Y+btF9ri96lmayGhoFbPHxtSHtuluMGWTQTdXOCdo7mBaTz/6c+ayJ6pQUgRIabWRELpGM9DjlA44yc7PcG2tpswYD2TpCx3PE5wj2b1AB4XpIEtu3vu2QTYUlN3C87qMuv4M=  ;
Message-ID: <20060329034619.420.qmail@web31804.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 19:46:19 -0800 (PST)
From: cyber rigger <cyber_rigger@yahoo.com>
Subject: Re: Need help reporting bug, no 3D accel with Matrox g400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143585894.11792.115.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the workarounds with a 2.6.15 kernel. They
didn't work for me.


I installed Debian's 2.6.16-1-k7 kernel (from sid).

The 3D acceleration WORKS now but I'm only getting
about HALF the frame rate (ppracer) as I did with
Debian's 2.6.8-3-k7 kernel (with xfree86).

Both test were with a Matrox g400.

Could the frame rate change just be a difference
between xfree86 and xorg?



--- Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-03-28 at 07:13 -0800, cyber rigger
> wrote:
> > 
> > DRM for MGA broken since 2005-Aug-04.
> > https://bugs.freedesktop.org/show_bug.cgi?id=4797
> > 
> > 
> > 
> > The 3D acceleration for mga appears to still be
> > broken. 
> 
> That bug is RESOLVED FIXED.  Did you try 2.6.16?  Do
> the xorg.conf
> workarounds mentioned in that bug report help?
> 
> Lee
> 
> 



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
