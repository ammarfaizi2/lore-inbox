Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRJNDxt>; Sat, 13 Oct 2001 23:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJNDxj>; Sat, 13 Oct 2001 23:53:39 -0400
Received: from confused.landsberger.com ([216.160.68.107]:58377 "EHLO
	mephistopheles.landsberger.com") by vger.kernel.org with ESMTP
	id <S274055AbRJNDxg>; Sat, 13 Oct 2001 23:53:36 -0400
Subject: Re: mount hanging 2.4.12
From: Brian Landsberger <brian@landsberger.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110132201150.3903-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110132201150.3903-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 13 Oct 2001 20:55:31 -0700
Message-Id: <1003031732.1261.1.camel@fux0r.landsberger.com>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed this happening once in a while on my CF loader (Sandisk
Imagemate) on and off again ever since 2.4.9. FAT filesystem,
usb-storage.



On Sat, 2001-10-13 at 19:02, Alexander Viro wrote:
> 
> 
> On Sat, 13 Oct 2001, Ed Tomlinson wrote:
> 
> > 
> > >On Sun, 14 Oct 2001, Riley Williams wrote:
> > 
> > >> He said in his original email that it was a USB SmartMedia reader,
> > >> which reads the SmartMedia cards used with FujiFilm digital cameras
> > >> (amongst others). The actual file system is determined by the cards
> > >> themselves and can't be changed.
> > 
> > >Ahem.  Which fs driver is used when it's successfully mounted?
> > 
> > fat.  Would an strace help?
> 
> It might, but another thing I'd like to see is stack trace of hung mount.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


