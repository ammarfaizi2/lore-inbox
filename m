Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbRAZTVn>; Fri, 26 Jan 2001 14:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131935AbRAZTVd>; Fri, 26 Jan 2001 14:21:33 -0500
Received: from [64.16.10.150] ([64.16.10.150]:21513 "EHLO cougar.intrinsyc.com")
	by vger.kernel.org with ESMTP id <S131127AbRAZTVZ>;
	Fri, 26 Jan 2001 14:21:25 -0500
Message-ID: <3A72074E.2115A9CE@intrinsyc.com>
Date: Fri, 26 Jan 2001 18:25:02 -0500
From: Daniel Chemko <dchemko@intrinsyc.com>
Reply-To: dchemko@intrinsyc.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.SOL.4.21.0101261713220.21592-100000@orange.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Microsoft are bad for dropping ICMP because of security.. .I mean try pinging
microsoft.com...



James Sutherland wrote:

> On Fri, 26 Jan 2001, Lars Marowsky-Bree wrote:
>
> > On 2001-01-26T16:04:03,
> >    "Randal, Phil" <prandal@herefordshire.gov.uk> said:
> >
> > > We may be right, "they" may be wrong, but in the real world
> > > arrogance rarely wins anyone friends.
> >
> > So you also turn of PMTU and just set the MTU to 200 bytes because broken
> > firewalls may drop ICMP ?
>
> No - a workaround is used to detect such "black holes". Much as I was
> advocating for ECN, in fact. Also note that some firewalls (Microsoft's in
> particular) DO drop ICMP packets.
>
> James.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
