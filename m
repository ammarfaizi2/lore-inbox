Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQKBXKt>; Thu, 2 Nov 2000 18:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbQKBXKj>; Thu, 2 Nov 2000 18:10:39 -0500
Received: from 3dyn134.com21.casema.net ([212.64.94.134]:9225 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129319AbQKBXK1>;
	Thu, 2 Nov 2000 18:10:27 -0500
Date: Fri, 3 Nov 2000 01:04:31 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
Message-ID: <20001103010431.A3977@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011021408040.2508-100000@saturn.homenet> <Pine.LNX.4.21.0011021738010.24579-100000@springhead.px.uk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.21.0011021738010.24579-100000@springhead.px.uk.com>; from dg@px.uk.com on Thu, Nov 02, 2000 at 05:39:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 05:39:03PM +0000, Dr. David Gilbert wrote:

> > So, here is David's mtrr patch. Although in his case ("only" 4G) it
> > shouldn't be needed.... it is for 36bit MTRRs I assume.
> 
> Thanks! That patch did the trick - our machine is now running lovely.

Your very rare problem was solved in 3 hours and 50 minutes. Most commercial
support shops try and fail to deliver 4 hour response times - this makes me
feel warm inside :-)

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
