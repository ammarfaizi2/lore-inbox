Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSAQHjx>; Thu, 17 Jan 2002 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288283AbSAQHjh>; Thu, 17 Jan 2002 02:39:37 -0500
Received: from daikokuya.demon.co.uk ([158.152.184.26]:50305 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S288255AbSAQHiW>; Thu, 17 Jan 2002 02:38:22 -0500
Date: Thu, 17 Jan 2002 07:40:03 +0000
To: Dave Jones <davej@suse.de>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, bcrl@redhat.com
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020117074003.GA5862@daikokuya.demon.co.uk>
In-Reply-To: <p73pu4aa63j.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0201161238530.9083-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201161238530.9083-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.25i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:-

> On 16 Jan 2002, Andi Kleen wrote:
> 
> > The first check is done automatically by the gcc preprocessor
> > anyways (it has a special check for the #ifndef BLA_H #define BLA_H #endif
> > construct for whole files and doesn't even bother to open them again on a
> > second include). So it's completely unnecessary.
> 
> Ahah! I knew I didn't imagine it. Either that or we've both had the same
> hallucination. 8-)

I told you over a beer, so maybe you were hallucinating 8^)

Neil.
