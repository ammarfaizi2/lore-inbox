Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCSWOi>; Tue, 19 Mar 2002 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293075AbSCSWO3>; Tue, 19 Mar 2002 17:14:29 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:14088 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293076AbSCSWOS>;
	Tue, 19 Mar 2002 17:14:18 -0500
Date: Tue, 19 Mar 2002 15:15:00 -0700
From: yodaiken@fsmlabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: yodaiken@fsmlabs.com, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020319151500.A23930@hq.fsmlabs.com>
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com> <20020316143916.A23204@hq.fsmlabs.com> <20020319120618.GA470@elf.ucw.cz> <20020319141231.A22305@hq.fsmlabs.com> <3C97B721.7A79C4F9@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 05:09:37PM -0500, Chris Friesen wrote:
> yodaiken@fsmlabs.com wrote:
> > 
> > On Tue, Mar 19, 2002 at 01:06:19PM +0100, Pavel Machek wrote:
> > > Hammer is designed for desktop, AFAICT. [Its slightly modified athlon,
> > > you see?]
> > 
> > Thanks for the insight. Only by reading LKM could
> > I have found out that AMD doesn't care about server space.
> 
> The sledgehammer is a bit more than a slightly modified athlon...
> 
> up to 8 way multiprocessing
> 64-bit addressing
> hypertransport
> integrated DDR memory controller

Look at www.amd.com front page  for some subtle hints on where
the margin is.


> 
> 
> -- 
> Chris Friesen                    | MailStop: 043/33/F10  
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

