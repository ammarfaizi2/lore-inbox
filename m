Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136197AbRECIDt>; Thu, 3 May 2001 04:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136211AbRECIDj>; Thu, 3 May 2001 04:03:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13514 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136197AbRECIDa>;
	Thu, 3 May 2001 04:03:30 -0400
Message-ID: <3AF110CB.6074C036@mandrakesoft.com>
Date: Thu, 03 May 2001 04:03:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Why recovering from broken configs is too hard
In-Reply-To: <20010503034755.A27693@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> OK, so you want CML2's "make oldconfig" to do something more graceful than
> simply say "Foo! You violated this constraint! Go fix it!"
[...]
> Have I got the point across yet?  There are *no* good solutions 
> to this problem.  There aren't even any clean ways to separate 
> easy cases from hard ones. 

No good solutions?  Then how come I use "make oldconfig" every day...

Are we to assume from your long missive that you are turning the
possible into the impossible?  :)

IMHO "make oldconfig" must stay.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
