Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbSLSWLv>; Thu, 19 Dec 2002 17:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSLSWKb>; Thu, 19 Dec 2002 17:10:31 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:19685 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267218AbSLSWJi>; Thu, 19 Dec 2002 17:09:38 -0500
Message-Id: <5.1.0.14.2.20021219141127.0a741280@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 19 Dec 2002 14:17:26 -0800
To: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021219.111221.115928165.davem@redhat.com>
References: <1040326115.28973.25.camel@irongate.swansea.linux.org.uk>
 <1040225146.1873.21.camel@localhost>
 <1040313919.2650.31.camel@localhost>
 <1040326115.28973.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:12 AM 12/19/2002 -0800, David S. Miller wrote:
>   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>   Date: 19 Dec 2002 19:28:35 +0000
>
>   On Thu, 2002-12-19 at 16:05, Max Krasnyansky wrote:
>   > Hmm, no replies. Nobody is interested in this or what ?
>   > I want to get this fixed otherwise I can't fix Bluetooth module
>   > refcounting. 
>   
>   Looks good to me, but its christmas so I wouldnt expect much to happen
>   till the new year
Ah, Christmas time :)

>I just got back from a long snowboarding trip, I'll look at this
>over the weekend before I disappear for another similar trip :)

Ok. Drop me a note and I'll push this stuff to BK were you can pull from. 
In the mean time I'll go bug other folks :). I want to do same kinda changes 
for the TTY ldisc code.

Max

