Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265292AbRF0IFm>; Wed, 27 Jun 2001 04:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265295AbRF0IFb>; Wed, 27 Jun 2001 04:05:31 -0400
Received: from pD951F985.dip.t-dialin.net ([217.81.249.133]:47108 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S265292AbRF0IFX>; Wed, 27 Jun 2001 04:05:23 -0400
Date: Wed, 27 Jun 2001 10:05:20 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Silviu Marin-Caea <silviu@delrom.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtek 8139 driver or sucky hardware?
Message-ID: <20010627100520.B18183@emma1.emma.line.org>
Mail-Followup-To: Silviu Marin-Caea <silviu@delrom.ro>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010627105256.2e75fdca.silviu@delrom.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010627105256.2e75fdca.silviu@delrom.ro>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Silviu Marin-Caea wrote:

> No matter what stupid things I do on it, I shouldn't be able to take the
> kernel down, right?
> 
> After I replaced the Realtek with a 3com, I could see all of the 60
> instances fighting like worms in shit, but the server survived.

Did the card share IRQs with another card?

What driver did you use? 8129/8139 or 8139too?
