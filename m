Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbRAZROn>; Fri, 26 Jan 2001 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbRAZROd>; Fri, 26 Jan 2001 12:14:33 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:57567 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130781AbRAZROS>; Fri, 26 Jan 2001 12:14:18 -0500
Date: Fri, 26 Jan 2001 17:14:12 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: "Randal, Phil" <prandal@herefordshire.gov.uk>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: RE: hotmail not dealing with ECN
In-Reply-To: <20010126173744.A5164@marowsky-bree.de>
Message-ID: <Pine.SOL.4.21.0101261713220.21592-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Lars Marowsky-Bree wrote:

> On 2001-01-26T16:04:03,
>    "Randal, Phil" <prandal@herefordshire.gov.uk> said:
> 
> > We may be right, "they" may be wrong, but in the real world
> > arrogance rarely wins anyone friends.
> 
> So you also turn of PMTU and just set the MTU to 200 bytes because broken
> firewalls may drop ICMP ?

No - a workaround is used to detect such "black holes". Much as I was
advocating for ECN, in fact. Also note that some firewalls (Microsoft's in
particular) DO drop ICMP packets.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
