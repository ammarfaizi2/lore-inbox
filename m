Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTIJR43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbTIJR43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:56:29 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:2790 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S265394AbTIJR42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:56:28 -0400
From: Ricardo Galli <gallir@uib.es>
To: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-fixed] 2.6.0-test5 was Re: [RETRY] 2.6-test5 =?iso-8859-15?q?didn't=09included=20it=20yet?= (old sk98lin driver makes eth unusable)
Date: Wed, 10 Sep 2003 19:56:24 +0200
User-Agent: KMail/1.5.3
References: <200309090221.33445.gallir@mnm.uib.es> <1063078780.3477.150.camel@spc>
In-Reply-To: <1063078780.3477.150.camel@spc>
Organization: UIB
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101956.24448.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 05:39, Steven Cole shaped the electrons to 
say:
> On Mon, 2003-09-08 at 18:21, Ricardo Galli wrote:
> > Just to recall Linus and Andrew:
> >    http://lkml.org/lkml/2003/8/24/65
> >
> > The patch works flawlessly since test4 was born (altough is reverting
> > a lot of "invalid's" back to "illegal").
>
> I was the original author of the illegal->invalid substitution patch.
>
> Here is Richard's patch with the invalid->illegal reversion redacted.
> (Changes to drivers/net/sk98lin/h/skgeinit.h removed).
>
> This patch is made against the current 2.6-test tree.
...

It works flawless in my (buggy?) motherboard, at least at 100 mbps.

...
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    scatter-gather:  enabled
...

Thanks,


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

