Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbRENXSr>; Mon, 14 May 2001 19:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262570AbRENXSh>; Mon, 14 May 2001 19:18:37 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:51592 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S262567AbRENXST>;
	Mon, 14 May 2001 19:18:19 -0400
Message-Id: <m14zRbL-000OdxC@amadeus.home.nl>
Date: Tue, 15 May 2001 00:18:07 +0100 (BST)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: LANANA: To Pending Device Number Registrants
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu> <3B006229.EA65A868@transmeta.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B006229.EA65A868@transmeta.com> you wrote:

> That's not the issue.  LILO takes whatever you pass to root= and converts
> it to a device number at /sbin/lilo time.  An idiotic practice on the
> part of LILO, in my opinion, that ought to have been fixed a long time
> ago.

That's why you want mount-root-by-partition-label, not by device
