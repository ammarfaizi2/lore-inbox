Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136192AbRDVQJN>; Sun, 22 Apr 2001 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136193AbRDVQJD>; Sun, 22 Apr 2001 12:09:03 -0400
Received: from t2.redhat.com ([199.183.24.243]:57842 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136192AbRDVQIu>; Sun, 22 Apr 2001 12:08:50 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010422114648.G28605@thyrsus.com> 
In-Reply-To: <20010422114648.G28605@thyrsus.com>  <20010422133947.A21908@se1.cogenit.fr> <Pine.GSO.4.21.0104220819490.28681-100000@weyl.math.psu.edu> 
To: esr@thyrsus.com
Cc: Alexander Viro <viro@math.psu.edu>, Francois Romieu <romieu@cogenit.fr>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 17:07:55 +0100
Message-ID: <27871.987955675@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  I've had my nose rubbed in how things really work.  That's why I want
> to fix the things that are broken about how things really work.

Then you're going to conjure up maintainers for the code which is currently 
orphaned?

For most stuff, the way to co-ordinate global changes is to discuss it on
l-k. If there's an active maintainer for parts which are affected, and if
they care, they'll respond to mail on l-k. That statement is a tautology
with my definition of 'active maintainer'. 

Bug reports are a red herring - users don't bother. They'll continue to 
sent idiotic bug reports to l-k for stuff which has already been reported 
and fixed, however we try to make life easy for them.

BTW, please try to ensure your .sig remains within the 4 lines recommended
by RFC1855. I appreciate that it's randomly chosen - but I also believe that
it's not beyond your capability to ensure that excessively long quotes are
not selected by whatever script provides the text to your MUA. If your 
political statement du jour cannot be expressed in one or two lines, it's 
inappropriate to include in mail to public fora.

--
dwmw2


