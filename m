Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285074AbRLLEVd>; Tue, 11 Dec 2001 23:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRLLEVX>; Tue, 11 Dec 2001 23:21:23 -0500
Received: from mono.mweb.co.za ([196.2.53.170]:28944 "EHLO mono.mweb.co.za")
	by vger.kernel.org with ESMTP id <S285074AbRLLEVS>;
	Tue, 11 Dec 2001 23:21:18 -0500
Subject: Re: [Patch] Compilation errors on some usb file
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Greg KH <greg@kroah.com>
Cc: LKM <linux-kernel@vger.kernel.org>
In-Reply-To: <20011211121955.A807@kroah.com>
In-Reply-To: <1008100443.3236.0.camel@localhost.localdomain> 
	<20011211121955.A807@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 06:31:34 +0200
Message-Id: <1008131499.4141.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 22:19, Greg KH wrote:
> On Tue, Dec 11, 2001 at 09:54:02PM +0200, Bongani Hlope wrote:
> > Sorry about the first two patches they both apply on top
> > of 2.4.17-pre7. I have attached both of them again I case ...
> 
> These patches do not make sense.  What kind of compile time errors do
> you get that these fix?  And what is the .config file that you are using
> to cause the errors?
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I tried 2.4.17-pre8  and it compiles correctly. The strange thing is
that the were no changes on my .config file (which seemed to be the
problem)

