Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132075AbQLaBgM>; Sat, 30 Dec 2000 20:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQLaBgC>; Sat, 30 Dec 2000 20:36:02 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:16907
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135624AbQLaBf4>; Sat, 30 Dec 2000 20:35:56 -0500
Date: Sun, 31 Dec 2000 14:05:27 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Tony Spinillo <tspin@epix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TEST13-PRE7 - Nvidia Kernel Module Compile Problem
Message-ID: <20001231140527.A21365@metastasis.f00f.org>
In-Reply-To: <3A4E3D6D.4D64E13@epix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4E3D6D.4D64E13@epix.net>; from tspin@epix.net on Sat, Dec 30, 2000 at 07:54:21PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bitch to nVidia.



  --cw

On Sat, Dec 30, 2000 at 07:54:21PM +0000, Tony Spinillo wrote:
    The nvidia kernel module (from www.nvidia.com) has compiled and loaded
    correctly with all test13-pre series up to pre6. I just tried to
    compile and load under pre7.
    I got the following:
    nv.c:860:unknown field `unmap' specified in initializer
    nv.c:860:warning: initialization from incompatible pointer type
    make:*** [nv.o] Error 1
    
    Is this due to a problem with the recent makefile changes or a problem
    with the nvidia module?
    
    Thanks!
    
    Tony
    
    The output for ver_linux:
    
    Kernel modules         2.3.23
    Gnu C                  egcs-2.91.66
    Gnu Make               3.79.1
    Binutils               2.10.0.24
    Linux C Library        2.1.3
    Dynamic linker         ldd (GNU libc) 2.1.3
    Procps                 2.0.7
    Mount                  2.10o
    Net-tools              1.57
    Console-tools          0.2.3
    Sh-utils               2.0
    -
    To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    Please read the FAQ at http://www.tux.org/lkml/
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
