Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270070AbTGMCJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 22:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270073AbTGMCJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 22:09:35 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9663 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270070AbTGMCJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 22:09:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: smiler@lanil.mine.nu
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sun, 13 Jul 2003 12:26:29 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
References: <200307112053.55880.kernel@kolivas.org> <200307130139.45477.kernel@kolivas.org> <1058027317.4363.8.camel@sm-wks1.lan.irkk.nu>
In-Reply-To: <1058027317.4363.8.camel@sm-wks1.lan.irkk.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131226.29452.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 02:28, Christian Axelsson wrote:
> On Sat, 2003-07-12 at 17:39, Con Kolivas wrote:
> > On Sat, 12 Jul 2003 10:13, Con Kolivas wrote:
> > > On Sat, 12 Jul 2003 09:37, Christian Axelsson wrote:
> > > > On Fri, 2003-07-11 at 16:30, Con Kolivas wrote:
> > > > > On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> >
> > snip snip snip
> >
> > Mike G suggested expiring tasks which use up too much cpu
> > time like in Davide's softrr patch which is a much better
> > solution to the forever reinserted into the active array concern.
> >
> > patch-SI-0307130021 is also available at
> > http://kernel.kolivas.org/2.5
>
> Problem seems to be gone (cant be 100% sure as I aint really sure WHAT
> trigged this behavior).

I'm as close to sure as I can be since this addressed it. Thanks to your 
feedback I would not have been able to figure it out or even know it was an 
issue. 

Surprisingly noone has said whether this patch does any good for their setup 
though.

Con

