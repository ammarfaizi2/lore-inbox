Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRA2Ul4>; Mon, 29 Jan 2001 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbRA2Ulq>; Mon, 29 Jan 2001 15:41:46 -0500
Received: from [63.109.146.2] ([63.109.146.2]:42232 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S129184AbRA2Ulj>;
	Mon, 29 Jan 2001 15:41:39 -0500
Message-ID: <4461B4112BDB2A4FB5635DE1995874320223F3@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Keith Owens'" <kaos@ocs.com.au>, Matthew Pitts <mpitts@suite224.net>
Cc: Jacob Anawalt <anawaltaj@qwest.net>, linux-kernel@vger.kernel.org
Subject: RE: Knowing what options a kernel was compiled with 
Date: Mon, 29 Jan 2001 12:41:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should someone submit a patch to copy the .config to a standard location as
part of "make install" or "make modules_install"? If included in the
official sources, that good example would encourage the distribution
maintainers do the same. 

Torrey Hoffman


>-----Original Message-----
>From: Keith Owens [mailto:kaos@ocs.com.au]
>[...]
>I know that some distributions ship .config but not all do.  A long way
>down on my TODO list is "submit a requirement to FHS that .config,
>System.map and other kernel related text files must be shipped in
>directory <foo>". 
>[...]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
