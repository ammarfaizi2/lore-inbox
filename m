Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269993AbRHESog>; Sun, 5 Aug 2001 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269991AbRHESo2>; Sun, 5 Aug 2001 14:44:28 -0400
Received: from sr2.terra.com.br ([200.176.2.128]:47626 "EHLO sr2.terra.com.br")
	by vger.kernel.org with ESMTP id <S269986AbRHESoL>;
	Sun, 5 Aug 2001 14:44:11 -0400
Date: Sun, 5 Aug 2001 15:44:17 -0300
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Alan <alan@clueserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ASUS CUV4X-D board
Message-ID: <20010805154417.A691@vinci>
In-Reply-To: <20010805194247.190906E42@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010805194247.190906E42@clueserver.org>; from alan@clueserver.org on Sun, Aug 05, 2001 at 10:27:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 10:27:34AM -0700, Alan wrote:
> I am running this under 2.4.3. I will be testing 2.4.7 this afternoon to see 
> if I can fix the problem.
> 
> The board works fine with a uniprocessor kernel.
> 
> When booking under the stock mandrake 8.0 kernel, I get cascading error 
> messages about clock problems and blaming a VIA686A chipset.
> 
> This has a VT82C686B PCI chipset.
> 
> I tried to find info on the web on this and was not ver successful.  (This is 
> at a friend's house.  He is out in the middle on nowhere and is lucky if he 
> get 28.8k connections.)
> 
> It this one of the non-correctable VIA chipsets?  Is there a workaround for 
> this?
> 
> It is a dual P-III 733 with a gig of ram. I would hate to see it go to waste. 
>  (Actually it will because it is not at MY house, but that is another 
> problem. ]:> )
> 
> I was going to get one of these boards. I am glad I did not...

	I have this board with a dual P-III 1 GHz and it works fine
with 2.4.7. Make sure you have at least revision 1007A for you BIOS
(the latest is 1010) and disable MPS 1.4 in BIOS configuration.

-- 
Rodrigo S. de Castro   <rcastro@ime.usp.br>

