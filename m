Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRBZHqe>; Mon, 26 Feb 2001 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBZHqY>; Mon, 26 Feb 2001 02:46:24 -0500
Received: from mail.isis.co.za ([196.15.218.226]:57611 "EHLO mail.isis.co.za")
	by vger.kernel.org with ESMTP id <S130188AbRBZHqJ>;
	Mon, 26 Feb 2001 02:46:09 -0500
Message-Id: <4.3.2.7.0.20010226094002.00af9f00@192.168.0.18>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Feb 2001 09:45:32 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Pat Verner <pat@isis.co.za>
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear
  (Lite-On)
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

26 Feb 2001:
Rebuilt the kernel to version 2.4.2-ac4, to include the latest tulip patches.

The performance is better,  but it is still not quite right; this time it 
received just over 48 MBytes before hanging :-(

Using a 3C590B card on Friday, I ran IPTRAF for about 6 hours, and several 
GBytes of data with no problems at all.  Unfortunately I have only one such 
card available, and our suppliers are quoting mid-March for delivery.
=Pat


At 10:42 AM 22/02/2001 +0000, Alan Cox wrote:
> > three Netgear NICs and am experiencing considerable trouble with the=20
> > combination:
> >
> > Kernel 2.4.[01]:        ifconfig shows that the card see's traffic on t=
> > he=20
> > network, but does not transmit anything (no response to ping).
>
>Use a current 2.4.*-ac. Jeff and co fixed this we think.
>
>Alan

--
Pat Verner				E-Mail:  pat@isis.co.za
           Isis Information Systems (Pty) Ltd
           PO Box 281, Irene, 0062, South Africa
Phone: +27-12-667-1411	      	Fax: +27-12-667-3800

