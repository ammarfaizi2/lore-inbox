Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUHNAMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUHNAMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 20:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267847AbUHNAMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 20:12:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39071 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267840AbUHNAMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 20:12:50 -0400
From: Andy Stewart <andystewart@comcast.net>
Reply-To: andystewart@comcast.net
Organization: Worcester Linux Users' Group
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: USB kernel oops 2.6.7
Date: Fri, 13 Aug 2004 20:10:47 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200408131947.55873.andystewart@comcast.net> <1092441613.803.40.camel@mindpipe>
In-Reply-To: <1092441613.803.40.camel@mindpipe>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408132010.58366.andystewart@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 13 August 2004 8:00 pm, Lee Revell wrote:
> On Fri, 2004-08-13 at 19:47, Andy Stewart wrote:
> > Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled.
> > Run rchotplug start
> > Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled.
> > Run rchotplug start
>
> Was hotplugging enabled at the time, or is this message wrong?  If the
> message is accurate, I would expect an Oops, the same way you often get
> an Oops if you unplug any piece of hardware that's not hot pluggable
> (assuming the hardware survives).
>
> Lee

Confirmed:  hotplugging was not enabled at the time.

- -- 
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA  USA
http://www.wlug.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHViPHl0iXDssISsRAqsfAJ0UaYjE8JKqk5AatQtv4dwslfQsYACeJCkY
VGDbpdn0pUQOQKbhBjBWCMo=
=5HFK
-----END PGP SIGNATURE-----
