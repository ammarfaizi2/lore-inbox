Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312860AbSCVVxK>; Fri, 22 Mar 2002 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312861AbSCVVxB>; Fri, 22 Mar 2002 16:53:01 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:6153 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S312860AbSCVVwu> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 16:52:50 -0500
Date: Fri, 22 Mar 2002 23:52:48 +0200 (EET)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BETA-0.97] Eigth test release of Tigon3 driver
In-Reply-To: <20020322.134208.64317316.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0203222352070.10668-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, David S. Miller wrote:

>    From: Pasi Kärkkäinen <pasik@iki.fi>
>    Date: Fri, 22 Mar 2002 23:37:34 +0200 (EET)
>
>    How about vlans.. should it say something about enabling hardware vlan
>    tagging when I configure some vlans?
>
> It just should work.  The VLAN layer might print something out,
> but the tg3 driver won't have anything interesting to say.

OK. Seems to work.

If I find some problems I'll let you know..


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

