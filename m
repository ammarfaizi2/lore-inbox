Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273568AbRIYWTI>; Tue, 25 Sep 2001 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273596AbRIYWS5>; Tue, 25 Sep 2001 18:18:57 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:59739 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S273568AbRIYWSo> convert rfc822-to-8bit; Tue, 25 Sep 2001 18:18:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Wed, 26 Sep 2001 00:16:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        =?iso-8859-1?q?Jacek=5Biso-8859-2=5DPop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva> <20010926000922.I8350@athlon.random>
In-Reply-To: <20010926000922.I8350@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15m0Wz-0002He-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> too much permissive (vm-tweaks-1 does something similar but not that
> permissive)

But it doesnt help neither.  I installed vm-tweaks-1 on a vanilla 2.4.10 and 
still got an __alloc_pages: 0-order allocation failure
I have no swap and 512 MB of RAM.



