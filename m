Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRK0TTr>; Tue, 27 Nov 2001 14:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282664AbRK0TTi>; Tue, 27 Nov 2001 14:19:38 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:11406 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S282693AbRK0TTY>;
	Tue, 27 Nov 2001 14:19:24 -0500
Message-Id: <m168nl3-000OVrC@amadeus.home.nl>
Date: Tue, 27 Nov 2001 19:19:05 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: heikki@indexdata.dk (Heikki Levanto)
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
In-Reply-To: <20011127200522.B27480@indexdata.dk>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011127200522.B27480@indexdata.dk> you wrote:

> is what gives the error messages in ifup (as well as when run by hand).
> Could not find much documentation for that /sbin/ip, redhat special?

You need to enable the netlink config options

> Does this indicate a kernel problem, redhat problem, or my problem?

your problem; it's even mentioned in the releasenotes..

