Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRJ2RUM>; Mon, 29 Oct 2001 12:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJ2RUC>; Mon, 29 Oct 2001 12:20:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32479 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279307AbRJ2RTu>;
	Mon, 29 Oct 2001 12:19:50 -0500
Date: Mon, 29 Oct 2001 12:20:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@caldera.de>
cc: Linus Torvalds <torvalds@transmeta.com>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ufs byteswapping cleanup
In-Reply-To: <20011029173950.D24272@caldera.de>
Message-ID: <Pine.GSO.4.21.0110291219310.28051-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Oct 2001, Christoph Hellwig wrote:

> Hi Linus,
> 
> the appended patch cleans up ufs to use sane inlines
> for byteswapping instead of the current macros that
> use variables from the enviroment (yuck!).
> 
> Older version already was in -ac.
> 
> Please apply,

Seconded.

