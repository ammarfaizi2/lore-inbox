Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbTCZQIA>; Wed, 26 Mar 2003 11:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbTCZQIA>; Wed, 26 Mar 2003 11:08:00 -0500
Received: from Mail1.KONTENT.De ([81.88.34.36]:46521 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id <S261754AbTCZQH7> convert rfc822-to-8bit;
	Wed, 26 Mar 2003 11:07:59 -0500
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Jeremy Jackson <jerj@coplanar.net>
Subject: Re: Preferred way to load non-free firmware
Date: Wed, 26 Mar 2003 17:19:07 +0100
User-Agent: KMail/1.5
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>, Greg KH <greg@kroah.com>,
       Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com> <200303261347.27137.oliver@neukum.org> <1048686722.1248.6.camel@contact.skynet.coplanar.net>
In-Reply-To: <1048686722.1248.6.camel@contact.skynet.coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261719.07959.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. März 2003 14:52 schrieb Jeremy Jackson:
> Check the list archive, there was someone telling about support they
> added for binary blobs in /proc (or was it sysfs?) for this (among
> others) very purpose.
>
> Please don't make the situation any worse.  I'd like to have some hope
> that Debian my publish their kernel-source package with a
> linux-x.x.x.tar.bz2 that matches the md5sum of the one on kernel.org
> some day.

I am sure such a patch, if the Debian people would get it into the
mainline kernel, would find its use.
But failing that I see no reason why any coder should jump through
hoops for the nontechnical concerns of any distribution, including Debian.
Using procfs for this is messier than including it in a header file.

	Regards
		Oliver

