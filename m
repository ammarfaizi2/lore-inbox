Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289728AbSAOXAh>; Tue, 15 Jan 2002 18:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289729AbSAOXAU>; Tue, 15 Jan 2002 18:00:20 -0500
Received: from [66.89.142.2] ([66.89.142.2]:23600 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S289728AbSAOW6d>;
	Tue, 15 Jan 2002 17:58:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs buffer spec -- second draft
Date: Wed, 16 Jan 2002 00:01:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <3C448D8F.80606@zytor.com>
In-Reply-To: <3C448D8F.80606@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Qca1-0001lA-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 09:14 pm, H. Peter Anvin wrote:
> Daniel Phillips wrote:
> > You apparently wrote:
> > > I don't think think this application alone is enough to add Yet Another 
> > > Version of CPIO.  However, if there are more compelling reasons to do so 
> > > for CPIO backup reasons itself I guess we could write it up and add it 
> > > to GNU cpio as "linux" format...
> > 
> > Oh, it is, really it is.  It's not just any application, and GNU already
> > has its own verion of cpio.
> 
> But not their own data format.

>From the man page:

   "The new ASCII format is portable between
   different machine architectures and can be used on any size file system,  but  is
   not supported by all versions of cpio; currently, it is only supported by GNU and
   Unix System V R4."

--
Daniel
