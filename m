Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130681AbRCEVWg>; Mon, 5 Mar 2001 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRCEVW0>; Mon, 5 Mar 2001 16:22:26 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:48907 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130681AbRCEVWM>;
	Mon, 5 Mar 2001 16:22:12 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: wayne.brown@altec.com
Date: Mon, 5 Mar 2001 22:21:59 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [OT] ncpfs (was Re: [acme@conectiva.com.br: Re: mke2fs /dev/...)
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <138D5C448FC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Mar 01 at 15:05, Wayne.Brown@altec.com wrote:
> 
> What is the current version of ncpfs, and where can it be found?  The most
> recent I could find (at www.ibiblio.org) was ncpfs-2.2.0 which dates back to May
> 1998, and I ran into the problem with select when trying to compile it on a
> current system.  I got it to work by compiling it on an old 2.0.x box that I
> haven't upgraded in several years, then moved it to my 2.4.x system.  It's been
> working fine for several months, but I'd like to be able to compile it on a
> current system without hacking the source.

Current released version is 2.2.0.18 and is available from Debian (and
maybe RedHat and others) and from its primary site
ftp://platan.vc.cvut.cz/pub/linux/ncpfs/latest. 

Latest beta version is 2.2.0.19.pre42, and is avaialble from
ftp://platan.vc.cvut.cz/private/ncpfs (and is packaged in experimental
Debian, AFAIK).

2.2.0.19 supports TCP mode of NCP, while 2.2.0.18 supports UDP/IPX only.
2.2.0.18 compiles on libc5/glibc2.x, while 2.2.0.19 currently compiles
on glibc2.2 only.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
