Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbRETCf2>; Sat, 19 May 2001 22:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbRETCfS>; Sat, 19 May 2001 22:35:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61966 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261380AbRETCfG>;
	Sat, 19 May 2001 22:35:06 -0400
Date: Sun, 20 May 2001 03:34:06 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Matthew Wilcox <matthew@wil.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010520033406.I23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca> <20010520031807.G23718@parcelfarce.linux.theplanet.co.uk> <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105200222.f4K2Mto02608@mobilix.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sat, May 19, 2001 at 10:22:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 10:22:55PM -0400, Richard Gooch wrote:
> The transaction(2) syscall can be just as easily abused as ioctl(2) in
> this respect.

But read() and write() cannot.

-- 
Revolutions do not require corporate support.
