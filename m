Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbRFSUHx>; Tue, 19 Jun 2001 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264759AbRFSUHo>; Tue, 19 Jun 2001 16:07:44 -0400
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:7810 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S264756AbRFSUHd>;
	Tue, 19 Jun 2001 16:07:33 -0400
Date: Tue, 19 Jun 2001 22:06:02 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adam Radford <aradford@3WARE.com>,
        "'Stefan Traby'" <stefan@hello-penguin.com>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        tytso@thunk.org
Subject: Re: 2.4.5 data corruption
Message-ID: <20010619220602.B27273@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EACFE@siamese> <E15CQkR-0006Tj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E15CQkR-0006Tj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 19, 2001 at 08:01:11PM +0100
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.5-fijiji2-aescrypto (i686)
X-APM: 100% -1 min
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79 
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 1 3 5 9 21 39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 08:01:11PM +0100, Alan Cox wrote:

> > Sometimes it takes either the kernel tree or our website some time to get 
> > in 'sync' with the latest driver version. The latest driver version is 
> > 1.02.00.007.  
> > 
> > There may be DAC960 like /proc support at some point for GUI haters.
> 
> Publishing enough info to let people write a GPL non gui management tool would
> be a win in itself

And on-disk superblock documentation.
I want to be able to recover from a single disk-failure and
power-fail conditions in all cases, not just in 50%.

3ware is simply unable to recover from some situations where recovery
is possible (reported to them at least two times).

Maybe they will understand this sometimes. I think that I have
a right to get my data back if it's possible.
It was extremly hard to explain them LGPL and the
fact that they violated it; so I expect not too much.

To not publish the specs is really extremly unfair;
it just shows how they care about my data.

-- 

  ciao - 
    Stefan
