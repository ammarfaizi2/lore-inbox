Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSCZQr2>; Tue, 26 Mar 2002 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSCZQrS>; Tue, 26 Mar 2002 11:47:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:943 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S312368AbSCZQrI>; Tue, 26 Mar 2002 11:47:08 -0500
Date: Tue, 26 Mar 2002 10:03:30 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020326100330.A20201@vger.timpanogas.org>
In-Reply-To: <20020320120455.A19074@vger.timpanogas.org> <20020320220241.GC29857@matchmail.com> <20020320152008.A19978@vger.timpanogas.org> <20020320152504.B19978@vger.timpanogas.org> <3C9935CA.38E6F56F@zip.com.au> <20020320234552.A21740@vger.timpanogas.org> <20020325181645.A17171@vger.timpanogas.org> <20020326014219.GA3536@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> That's good news.
> 
> Are you still working on the A/B list patch?  I'd imagine that it could make
> several problems easier to fix in the block layer.
> 

Yes.  I am asking Darren Major, who wrote the A/B implementation 
in NetWare to review the patch before we submit it.  It may affect
some drivers.  We are verifying that the change I instrumented 
will not break anything.

Jeff


> > :-)
> >
> 
> :)
