Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266673AbRGOQIh>; Sun, 15 Jul 2001 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266669AbRGOQI1>; Sun, 15 Jul 2001 12:08:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54983 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266682AbRGOQIN>;
	Sun, 15 Jul 2001 12:08:13 -0400
Date: Sun, 15 Jul 2001 12:08:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: volodya@mindspring.com
cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        lkml <linux-kernel@vger.kernel.org>, reiser@namesys.com
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <Pine.LNX.4.20.0107151158360.645-100000@node2.localnet.net>
Message-ID: <Pine.GSO.4.21.0107151204060.24930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Jul 2001 volodya@mindspring.com wrote:

> Which is a good point - can ext2 handle more than 4gig partitions ? I have

It can.

> some vague ideas that it doesn't (and that it does not handle files more
> than 2gig long).

It does.

