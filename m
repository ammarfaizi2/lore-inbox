Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272289AbRIEUGs>; Wed, 5 Sep 2001 16:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272291AbRIEUGi>; Wed, 5 Sep 2001 16:06:38 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:57437 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S272289AbRIEUGW>; Wed, 5 Sep 2001 16:06:22 -0400
Date: Wed, 5 Sep 2001 18:59:46 +0100
From: Adrian Burgess <kernel@corrosive.freeserve.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE Problems on SIS 735?
Message-ID: <20010905185946.A6828@corrosive.freeserve.co.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010905085251.A3154@corrosive.freeserve.co.uk> <E15ebN4-0005g4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15ebN4-0005g4-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.9-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 01:01:30PM +0100, Alan Cox wrote:
> 
> The driver tried to do a UDMA transfer, and waited and waited, and gave up
> on it. With cable errors I'd expect to see a badCRC message or two.
> 
> Does it behave better with an older kernel (say 2.4.7 or so) ?

Alan,
Nope.  Been having this problem since I installed the motherboard.  I'll
have to see about getting another cable, I think - I've used the one that
came with the motherboard, and another that came with my Maxtor HD.
Cheers,
Adrian.

-- 
PGP Public Key at http://www.corrosive.freeserve.co.uk/text/pubkey.asc
