Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbRCCSdY>; Sat, 3 Mar 2001 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbRCCSdO>; Sat, 3 Mar 2001 13:33:14 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:54535 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129652AbRCCSdC>; Sat, 3 Mar 2001 13:33:02 -0500
Message-ID: <3AA138A1.72E99C7C@jonmasters.org>
Date: Sat, 03 Mar 2001 18:32:01 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organisation of Broken Dreams
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Forwarding broadcast traffic
In-Reply-To: <200103031054.KAA29868@localhost.localdomain> <3AA12CD8.7F948E0D@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:

> try bridging instead if ip forwarding.  use netfilter too if you want

I mentioned bridging before - I don't want some kind of transparent
bridge, really so what I would need is for the router to be contactable
in the same way as before and for regular traffic to pass normally but
with a special arrangement for certain broadcast traffic.

Is it possible to selectively bridge broadcast traffic in the way I have
described?

Normally of course I'd have the router either being a standard router or
a bridge but in this case some kind of hybrid arrangement would be
preferable.

Thanks for your help,
			--jcm
