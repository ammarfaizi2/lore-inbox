Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278549AbRKDUGx>; Sun, 4 Nov 2001 15:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKDUGd>; Sun, 4 Nov 2001 15:06:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16616 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277435AbRKDUG3> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 15:06:29 -0500
Date: Sun, 4 Nov 2001 15:06:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011104205248.Q14001@unthought.net>
Message-ID: <Pine.GSO.4.21.0111041502390.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, [iso-8859-1] Jakob Østergaard wrote:

> So just ignore square brackets that have "=" " " and ">" between them ?
> 
> What happens when someone decides  "[---->   ]" looks cooler ?

First of all, whoever had chosen that output did a fairly idiotic thing.
But as for your question - you _do_ know what regular expressions are,
don't you?  And you do know how to do this particular regex without
any use of library functions, right?

