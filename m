Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131700AbQKWO7g>; Thu, 23 Nov 2000 09:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131991AbQKWO70>; Thu, 23 Nov 2000 09:59:26 -0500
Received: from sal.qcc.sk.ca ([198.169.27.3]:49421 "HELO sal.qcc.sk.ca")
        by vger.kernel.org with SMTP id <S131700AbQKWO7K>;
        Thu, 23 Nov 2000 09:59:10 -0500
Date: Thu, 23 Nov 2000 08:29:04 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess
Message-ID: <20001123082904.B1485@qcc.sk.ca>
Mail-Followup-To: Charles Cazabon <linux@discworld.dyndns.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <UTC200011230224.DAA141466.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <UTC200011230224.DAA141466.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Nov 23, 2000 at 03:24:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl <Andries.Brouwer@cwi.nl> wrote:
> > Thats because too many things get put on a line then.
> > And because we do [<foo>] [<bar>]  not   [<foo>][<bar>] ?
> 
> In the good old times we had  foo bar  for a total of 8*(8+1) = 72
> positions. Now we have [<foo>] [<bar>] which takes 8*(8+1+4) = 104
> positions. If you turned this into 6 items per line instead of 8,
> it would certainly improve matters a bit.

The original poster complained the output lines were too wide for the screen
on his PC.  Perhaps he should change his console mode to 132 characters wide
(via SVGATextMode or such) -- voila, no more problem, no broken kernel patches.

Charles 
-- 
--------------------------------------------------------------
Charles Cazabon                   <linux@discworld.dyndns.org>
My opinions do not necessarily represent those of my employer.
--------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
