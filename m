Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291653AbSBTFOD>; Wed, 20 Feb 2002 00:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291654AbSBTFNx>; Wed, 20 Feb 2002 00:13:53 -0500
Received: from elede1.lnk.telstra.net ([139.130.64.220]:57097 "EHLO
	proxy2.edmi.com.au") by vger.kernel.org with ESMTP
	id <S291653AbSBTFNp>; Wed, 20 Feb 2002 00:13:45 -0500
From: "Alex Song" <alexs@pdd.edmi.com.au>
To: "Alex Song" <alexs@pdd.edmi.com.au>,
        "Sandeep Gopal Nijsure" <nijsure@cs.unt.edu>,
        <linux-kernel@vger.kernel.org>
Subject: RE: About net part of the kernel
Date: Wed, 20 Feb 2002 15:13:39 +1000
Message-ID: <000f01c1b9cd$5b592e50$1501010a@alexs>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <000e01c1b9cc$dddf2420$1501010a@alexs>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ignore what i said before, i misread the question.

cheers,

alex

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alex Song
> Sent: Wednesday, 20 February 2002 3:10 PM
> To: Sandeep Gopal Nijsure; linux-kernel@vger.kernel.org
> Subject: RE: About net part of the kernel
>
>
> you don't have to change and part of the kernel, you can do what you want
> with ipchains (2.2 kernels) or iptables (2.4 kernels).
>
> cheers,
>
> alex
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Sandeep Gopal
> > Nijsure
> > Sent: Wednesday, 20 February 2002 2:59 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: About net part of the kernel
> >
> >
> > Hi,
> >
> > I want to make, say, a machine 10.0.0.5 accept an IP packet with the
> > destination address of 10.0.0.2. I hope I can do this by
> changing a bit of
> > kernel networking code, where it's decided whether to accept an
> IP packet
> > as a local packet.. I could not locate the code.. could anybody tell me
> > where exactly the decision process take place?
> >
> > Thanks a lot..
> > Sandeep
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

