Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRFST7n>; Tue, 19 Jun 2001 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbRFST7e>; Tue, 19 Jun 2001 15:59:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46591 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264432AbRFST7W>;
	Tue, 19 Jun 2001 15:59:22 -0400
Date: Tue, 19 Jun 2001 15:59:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Joerg Pommnitz <pommnitz@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <20010619194850.80973.qmail@web13303.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0106191557030.22741-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Joerg Pommnitz wrote:

>  > But that foregoes the point that the code is far more complex and
>  > harder to make 'obviously correct', a concept that *does* translate
>  > well to userspace.
> 
> Check the state threads library from SGI:
> http://oss.sgi.com/projects/state-threads/
> 
> It should provide the code clarity one is used from
> "real" threads and the efficiency of a state machine.

... along with usual quality of SGI design and their normal attention
to potential races. Thank you, I'll pass.

