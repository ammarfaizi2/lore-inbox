Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbRETCub>; Sat, 19 May 2001 22:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbRETCuV>; Sat, 19 May 2001 22:50:21 -0400
Received: from lpce017.lss.emc.com ([168.159.62.17]:33796 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261391AbRETCuR>; Sat, 19 May 2001 22:50:17 -0400
Date: Sat, 19 May 2001 22:48:58 -0400
Message-Id: <200105200248.f4K2mws02918@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520033406.I23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu>
	<E1517Jf-0008PV-00@the-village.bc.nu>
	<200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>
	<20010520031807.G23718@parcelfarce.linux.theplanet.co.uk>
	<200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>
	<20010520033406.I23718@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
> On Sat, May 19, 2001 at 10:22:55PM -0400, Richard Gooch wrote:
> > The transaction(2) syscall can be just as easily abused as ioctl(2) in
> > this respect.
> 
> But read() and write() cannot.

Sure they can. I can pass a pointer to a structure to either of them.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
