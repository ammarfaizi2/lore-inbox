Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136184AbRDVPoS>; Sun, 22 Apr 2001 11:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136185AbRDVPoK>; Sun, 22 Apr 2001 11:44:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:8199 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136184AbRDVPn5>;
	Sun, 22 Apr 2001 11:43:57 -0400
Date: Sun, 22 Apr 2001 11:44:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Request for comment -- a better attribution system
Message-ID: <20010422114407.F28605@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Giacomo A. Catenazzi" <cate@dplanet.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <E14r6oh-0004Zu-00@the-village.bc.nu> <3AE2B847.C4EE45E9@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE2B847.C4EE45E9@dplanet.ch>; from cate@dplanet.ch on Sun, Apr 22, 2001 at 12:53:59PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi <cate@dplanet.ch>:
> Alternativelly we can generate MAINTAINER from ESR's map headers.
> In this case we should include this script in the Linus script to
> automagically create the i386 defconfig.

Aha!  Somebody is actually *thinking* rather than having a
conservative reflex.  Yes, boys and girls, this is exactly how I
planned to solve the I-want-to-be-able-to-grep-it problem.

Giacomo hasn't resolved the larger question of whether my distributed-
attribution proposal is a good idea or not.  What he *has* done is
demonstrated that the resistance to it is mostly rationalized rather
than rational.  Otherwise somebody else would have seen this a lot
sooner.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

