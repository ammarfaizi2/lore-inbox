Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292585AbSBZSJV>; Tue, 26 Feb 2002 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292592AbSBZSJM>; Tue, 26 Feb 2002 13:09:12 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:779 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S292585AbSBZSIx> convert rfc822-to-8bit;
	Tue, 26 Feb 2002 13:08:53 -0500
Date: Tue, 26 Feb 2002 20:08:51 +0200 (EET)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <jgarzik@mandrakesoft.com>,
        <linux-net@vger.kernel.org>
Subject: Re: [BETA] First test release of Tigon3 driver
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0202262003241.10668-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Feb 2002, David S. Miller wrote:

>
> This is to announce the first test release of a new Broadcom Tigon3
> driver written by Jeff and myself.  Get it at:
>

Does/Will this driver support NICE-extensions as does the Broadcom's
driver? I've been successfully using broadcom's driver with the
nice-patched vlan-code for a couple of months now..

I think Ben Greear is about to submit NICE patch for VLAN to be included
in the kernel soon..

(NICE extensions enable hardware vlan-tagging etc for linux VLAN code).


btw. Does any other driver support NICE-extensions?


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

