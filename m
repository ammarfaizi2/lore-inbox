Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261159AbREOReZ>; Tue, 15 May 2001 13:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261192AbREORcu>; Tue, 15 May 2001 13:32:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35782 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261172AbREORc2>;
	Tue, 15 May 2001 13:32:28 -0400
Date: Tue, 15 May 2001 13:32:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0105151330480.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, James Simmons wrote:

> I would use write except we use write to draw into the framebuffer. If I
> write to the framebuffer with that data the only thing that will happen is
> I will get pretty colors on my screen. 

Yes. And we also use write to send data to printer. So what? Nobody makes
you use the same file.

