Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278370AbRJMTRR>; Sat, 13 Oct 2001 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278369AbRJMTRI>; Sat, 13 Oct 2001 15:17:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:61707 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278368AbRJMTRC>;
	Sat, 13 Oct 2001 15:17:02 -0400
Date: Sat, 13 Oct 2001 16:17:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Patrick McFarland <unknown@panax.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
In-Reply-To: <20011013144220.P249@localhost>
Message-ID: <Pine.LNX.4.33L.0110131614080.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Patrick McFarland wrote:

> Ill reiterate something here, im on a p133 with 16 megs. Yeah, the
> kind of the crappy ide controller that eats cpu time to swap. (Enough
> so that my mouse pointer will freeze in X that its swapping so much.
> Swapping is the only thing ive found that can pull that off) Swapping
> the least ammount would be the best for a box like that.

Absolutely true.  Are you willing to help the VM developers test
their patches by seeing how well stuff runs on your box, so we
can try and make the VM work better for you ?

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

