Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDTVlD>; Fri, 20 Apr 2001 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbRDTVky>; Fri, 20 Apr 2001 17:40:54 -0400
Received: from t2.redhat.com ([199.183.24.243]:61680 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132039AbRDTVkr>; Fri, 20 Apr 2001 17:40:47 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010420173514.A21392@thyrsus.com> 
In-Reply-To: <20010420173514.A21392@thyrsus.com>  <20010420172435.A21252@thyrsus.com> <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home> <6817.987801548@redhat.com> <20010420172435.A21252@thyrsus.com> <7043.987802140@redhat.com> 
To: esr@thyrsus.com
Cc: Nicolas Pitre <nico@cam.org>, Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Apr 2001 22:39:24 +0100
Message-ID: <7261.987802764@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
>  Even supposing that's so, a 36% rate of broken symbols is way too
> high.  It argues that we need to do a thorough housecleaning at least
> once in order to get back to an acceptably low stable rate.

Accepted. Can we let the 2.4 "angry penguin"-enforced stabilising period
finish, and give the arch and subsystem maintainers a chance to finally
brave the wrath of Linus and submit their patches, before we attempt do to
it though?

--
dwmw2


