Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTHXQ2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTHXQ2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:28:44 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:21725 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S261243AbTHXQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:28:43 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: azarah@gentoo.org
Subject: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
Date: Sun, 24 Aug 2003 18:28:37 +0200
User-Agent: KMail/1.5.3
Cc: Mirko Lindner <mlindner@syskonnect.de>,
       LKML <linux-kernel@vger.kernel.org>
References: <200308121301.43873.gallir@uib.es> <200308121440.50395.gallir@uib.es> <1061663721.13460.5.camel@nosferatu.lan>
In-Reply-To: <1061663721.13460.5.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241828.37736.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 August 2003 20:35, Martin Schlemmer shaped the electrons to shout:
...
> > > Known issue.
> > >
> > > Mirko will have a look as soon as he have time.
> >
> > Thanks, I just sent a Kconfig patch as a workaround:
> >
> > http://lkml.org/lkml/2003/8/12/83
>
> Should work fine with version 6.16 of the driver (does so
> here at least with a P4C800):
>
> http://www.syskonnect.com/syskonnect/support/driver/zip/linux/sk98lin_2.6.0-test3_patch.gz

Tested with -test4, it works nicely. Thanks.

Could this new version be included in -test5? Otherwise is useless for 
lots of users (at least I received lots of "me too").


-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

