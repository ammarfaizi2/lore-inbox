Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRIVQAX>; Sat, 22 Sep 2001 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIVQAN>; Sat, 22 Sep 2001 12:00:13 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:53668
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S271800AbRIVP7y>; Sat, 22 Sep 2001 11:59:54 -0400
Date: Sat, 22 Sep 2001 09:00:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Tainting kernels for non-GPL or forced modules
Message-ID: <20010922090013.O17555@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <27975.1001164529@ocs3.intra.ocs.com.au> <20010922153344.A25557@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010922153344.A25557@telia.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 03:33:44PM +0200, Andr? Dahlqvist wrote:
> Keith Owens <kaos@ocs.com.au> wrote:
> 
> > IMHO the default should be complain and taint, even though it will
> > generate lots of newbie questions to l-k.
> 
> Wasn't it those questions that this feature was meant to prevent in the
> first place?

Er, I thought the whole point of this was so that we would know if the
kernel had been 'tainted' by a non-free module that we can't debug.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
