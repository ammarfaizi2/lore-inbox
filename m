Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318236AbSIOUAx>; Sun, 15 Sep 2002 16:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318240AbSIOUAx>; Sun, 15 Sep 2002 16:00:53 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:35061 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318236AbSIOUAw>; Sun, 15 Sep 2002 16:00:52 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D843008.1AFA5259@digeo.com> 
References: <3D843008.1AFA5259@digeo.com>  <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> 
To: Andrew Morton <akpm@digeo.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Daniel Phillips <phillips@arcor.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Sep 2002 21:05:34 +0100
Message-ID: <3742.1032120334@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akpm@digeo.com said:
>  Uh, I feel obliged to respond to these statements just in case anyone
> thinks they contain anything which is correct.

> I have spent twelve months doing kernel development without kgdb and
> eighteen months with.  "With" is better.

I have to agree. I don't ever recall using GDB to debug my own code, and I'm
half-willing to accept the testosterone-fuelled position on that case, but
in the cases where I'm supposed to be 'certifying' or otherwise debugging
code which is provided by a customer, but which appears to have been written
by a crack-smoking hobo they dragged in off the street, it's been _very_
useful.

--
dwmw2


