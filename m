Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRJNAQz>; Sat, 13 Oct 2001 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRJNAQp>; Sat, 13 Oct 2001 20:16:45 -0400
Received: from imladris.infradead.org ([194.205.184.45]:58119 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S271978AbRJNAQZ>;
	Sat, 13 Oct 2001 20:16:25 -0400
Date: Sun, 14 Oct 2001 01:16:45 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Ed Tomlinson <tomlins@CAM.ORG>, <linux-kernel@vger.kernel.org>
Subject: Re: mount hanging 2.4.12 
In-Reply-To: <Pine.GSO.4.21.0110131955080.3903-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110140104480.13940-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander.

On Sat, 13 Oct 2001, Alexander Viro wrote:

 > On Sat, 13 Oct 2001, Ed Tomlinson wrote:

 >> With kernel 2.4.12 I am having problems with mount hanging.
 >>
 >> oscar% mount /fuji
 >> oscar% cd /fuji
 >> oscar% ls
 >> dcim
 >> oscar% cd
 >> oscar% umount /fuji
 >> oscar% mount /fuji
 >> mount: wrong fs type, bad option, bad superblock on /dev/sda1,
 >>        or too many mounted file systems
 >> oscar% mount /fuji

 > Lovely... What filesystem type do you have there?

He said in his original email that it was a USB SmartMedia reader,
which reads the SmartMedia cards used with FujiFilm digital cameras
(amongst others). The actual file system is determined by the cards
themselves and can't be changed.

I have a Fuji MX2700 digital camera myself, and a separate USB reader
for downloading it to computer (the inbuilt serial link is far too
slow), but I'm in the position that the only USB enabled computer in
the household is my wife's one which only runs Win98, and can't be
changed without incurring my wife's severe displeasure. As a result,
I'm not able to test anything USB out.

Best wishes from Riley.

