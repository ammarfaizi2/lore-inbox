Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316989AbSFKKXm>; Tue, 11 Jun 2002 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSFKKXl>; Tue, 11 Jun 2002 06:23:41 -0400
Received: from userk185.dsl.pipex.com ([62.188.58.185]:32220 "EHLO
	userk185.dsl.pipex.com") by vger.kernel.org with ESMTP
	id <S316989AbSFKKXk>; Tue, 11 Jun 2002 06:23:40 -0400
From: "Sean Hunter" <sean@uncarved.com>
Date: Tue, 11 Jun 2002 11:23:40 +0100
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth 'depredation'
Message-ID: <20020611102340.GA31741@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	DervishD <raul@pleyades.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3D05AA6E.mailKB1BHA1W@viadomus.com> <20020611084727.A5997@dev.sportingbet.com> <3D05D05F.mailUZ11UHLV@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 12:26:39PM +0200, DervishD wrote:
> 
>     Hi Sean :)
> 
> >Build a kernel with traffic classifaction and CBQ, and use "tc".
> 
>     Oops :(( I thought that it was easier...
> 
>     Well, thanks. I'll take a look at the tc documentation :)

I should have added "QoS".  In fact, you may be able to do some of this without
too much complexity.

Sean
