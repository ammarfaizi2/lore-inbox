Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275119AbRIYRZi>; Tue, 25 Sep 2001 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275120AbRIYRZ2>; Tue, 25 Sep 2001 13:25:28 -0400
Received: from mail.delfi.lt ([213.197.128.86]:14092 "HELO
	mx-outgoing.delfi.lt") by vger.kernel.org with SMTP
	id <S275119AbRIYRZK>; Tue, 25 Sep 2001 13:25:10 -0400
Date: Tue, 25 Sep 2001 19:25:18 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: all files are executable in vfat
To: William Scott Lockwood III <thatlinuxguy@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu> <20010925170129.7AF958F659@mail.delfi.lt> <3BB0B9A7.2010906@antefacto.com>
 <OE51Xok84FTA7OIkUqL00001070@hotmail.com>
In-Reply-To: <OE51Xok84FTA7OIkUqL00001070@hotmail.com>
X-Mailer: Mahogany, 0.64 'Sparc', compiled for Linux 2.4.7 i686
Message-Id: <20010925172530.C6C5A8F77D@mail.delfi.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001 12:19:09 -0500 William Scott Lockwood III <thatlinuxguy@hotmail.com> wrote:

WSLI> dmask?
WSLI> 
WSLI> ----- Original Message -----
WSLI> > I too used noexec to get around this problem. Is there anyway to get umask
WSLI> > to ignore directories? I.E. (v)fat should always leave directories
WSLI> executable
WSLI> > in my opinion?

There is no such option in man and using it did not help.


Regards,
Nerijus

