Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJMXzS>; Sat, 13 Oct 2001 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRJMXzI>; Sat, 13 Oct 2001 19:55:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50078 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271741AbRJMXzD>;
	Sat, 13 Oct 2001 19:55:03 -0400
Date: Sat, 13 Oct 2001 19:55:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12 
In-Reply-To: <20011013234121.31B3B24D64@oscar.casa.dyndns.org>
Message-ID: <Pine.GSO.4.21.0110131955080.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Ed Tomlinson wrote:

> Hi,
> 
> With kernel 2.4.12 I am having problems with mount hanging.
> 
> oscar% mount /fuji
> oscar% cd /fuji
> oscar% ls
> dcim
> oscar% cd
> oscar% umount /fuji
> oscar% mount /fuji
> mount: wrong fs type, bad option, bad superblock on /dev/sda1,
>        or too many mounted file systems
> oscar% mount /fuji

Lovely... What filesystem type do you have there?

