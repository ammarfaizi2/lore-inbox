Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbTCDBlW>; Mon, 3 Mar 2003 20:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268973AbTCDBlW>; Mon, 3 Mar 2003 20:41:22 -0500
Received: from mx01.cyberus.ca ([216.191.240.22]:46340 "EHLO mx01.cyberus.ca")
	by vger.kernel.org with ESMTP id <S268971AbTCDBlV>;
	Mon, 3 Mar 2003 20:41:21 -0500
Date: Mon, 3 Mar 2003 20:51:06 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
       "" <david.knierim@tekelec.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, "" <linux-kernel@vger.kernel.org>,
       "" <alexander@netintact.se>, "" <raarts@office.netland.nl>
Subject: Re: PCI init issues
In-Reply-To: <1046707275.16884.3.camel@rth.ninka.net>
Message-ID: <20030303204829.M67734@shell.cyberus.ca>
References: <20030302121050.F61365@shell.cyberus.ca> 
 <20030303151412.A15195@jurassic.park.msu.ru> <1046707275.16884.3.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Mar 2003, David S. Miller wrote:

> Anyone know if FreeBSD fares better in situations like this?

All BSDs apparently have this problem. Ive heard rumors of windows XP
working just fine with the same setup on these mboards.
Unfortunately up north we have igloos so i cant verify these rumors ;->

cheers,
jamal
