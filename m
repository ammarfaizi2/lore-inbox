Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291390AbSBSNXn>; Tue, 19 Feb 2002 08:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBSNXd>; Tue, 19 Feb 2002 08:23:33 -0500
Received: from ns.suse.de ([213.95.15.193]:32779 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291390AbSBSNXT>;
	Tue, 19 Feb 2002 08:23:19 -0500
Date: Tue, 19 Feb 2002 14:23:12 +0100
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Whitespace PCI cleanups
Message-ID: <20020219142312.B8293@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@suse.cz>, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020218181623.GA122@elf.ucw.cz> <20020219102752.7dd1e21c.rusty@rustcorp.com.au> <20020219090721.GB8851@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219090721.GB8851@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Tue, Feb 19, 2002 at 10:07:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 10:07:21AM +0100, Pavel Machek wrote:

 > I did not want to give it to *two* maintainers for tracking, because
 > you might potentially stomp on each other. 

 I don't think thats an issue. Even if Rusty and myself both
 send the same small bits to Linus, it doubles the chances of him
 not dropping the patch for no reason.

 Whilst I'm chainsawing up some of the bigger bits, if the smaller
 bits go to Linus through Rusty, that makes everyones life easier.
 Having both of us pick up small bits isn't so much duplicating
 work, its an extra safety net of sorts. If I overlook something,
 maybe Rusty will pick it up, and vice versa.

 Hopefully Rusty will get a good acceptance on small bits before
 he ends up with a huge collection 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
