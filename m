Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSD0UG3>; Sat, 27 Apr 2002 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSD0UFA>; Sat, 27 Apr 2002 16:05:00 -0400
Received: from host213-122-210-220.in-addr.btopenworld.com ([213.122.210.220]:17795
	"EHLO Wasteland") by vger.kernel.org with ESMTP id <S314451AbSD0UEX>;
	Sat, 27 Apr 2002 16:04:23 -0400
Message-Id: <m171YQJ-000GQtC@Wasteland>
Content-Type: text/plain; charset=US-ASCII
From: Matthew M <matthew.macleod@btinternet.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Microcode update driver
Date: Sat, 27 Apr 2002 21:01:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0204272150130.2833-100000@mustard.heime.net>
Cc: linux-kernel@vger.kernel.org
X-Operating-System: Debian GNU/Linux
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 27 April 2002 8:51 pm, RS wrote:
> ok
>
> running redhat, I have no microcode_ctl. but still, the kernel tells me
> 'IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>' during boot.
>
> where can i find it? Do I need it?

microcode_ctl is the userland utility which actually soed the uploading of 
microcode. You will need to get the appropriate package, and this will come 
with microcode.dat - then you should actually be able to update your 
microcode. The message in your kernel log is just the driver initialisation.

*MatthewM*
- -- 
 
Sometimes love ain't nothing but a misunderstanding between two fools.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ywOfoVQMDIAmueURAvGVAJ95OFzC163RQ0veUPfndUqy7QzuWQCeOTKS
J9hy4k+y8O67Fnk5vPn9R6s=
=z/wB
-----END PGP SIGNATURE-----
