Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313143AbSDDLrN>; Thu, 4 Apr 2002 06:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSDDLrF>; Thu, 4 Apr 2002 06:47:05 -0500
Received: from ns.suse.de ([213.95.15.193]:17422 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313143AbSDDLqz>;
	Thu, 4 Apr 2002 06:46:55 -0500
Date: Thu, 4 Apr 2002 13:46:54 +0200
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.7-dj3 KL133/KM133 problems (screen corruption/MWQ)
Message-ID: <20020404134654.O20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1017900251.760478.2242.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 04:04:11PM +1000, Andre Pang wrote:

 > The patch is against 2.5.7-dj3.  It's being submitted to Marcelo
 > for inclusion in 2.4.19, and Alan has picked it up for
 > 2.4-ac.  Please forward it to Linus for inclusion in the main
 > kernel tree, or let me know if you want me to send it to him.

Yup, the earlier one you sent is sitting in my 'pending' folder, waiting
to be applied along with around 2 dozen other patches.
As you can probably guess from the 2.5.8-pre1 changelog, resyncing with
Linus is under way, so I want to try and push lots more stuff before
I start merging any extra bits. (Trying to merge to a moving target
isn't made any easier when your tree is moving also 8)

So yes, sure I'll apply it, but you may be quicker just sending it
to Linus yourself for now.  For the next week or so, this applies to
everyone else sending me patches. I'm not dropping them, but the
inbound queue is just backlogging a little.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
