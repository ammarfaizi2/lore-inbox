Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbREOVrS>; Tue, 15 May 2001 17:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261592AbREOVrJ>; Tue, 15 May 2001 17:47:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35736 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261596AbREOVq5>;
	Tue, 15 May 2001 17:46:57 -0400
Date: Tue, 15 May 2001 17:46:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chip Salzenberg <chip@valinux.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515144243.I3098@valinux.com>
Message-ID: <Pine.GSO.4.21.0105151746320.22958-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Chip Salzenberg wrote:

> According to Linus Torvalds:
> > I don't see why we couldn't expose the "driver name" for any file
> > descriptor.
> 
> Is it wise to assume that there is only one such name for *any* file
> descriptor?

Type of filesystem where the file came from? Sure.

