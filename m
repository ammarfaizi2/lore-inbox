Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264728AbRFSTMs>; Tue, 19 Jun 2001 15:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264732AbRFSTMi>; Tue, 19 Jun 2001 15:12:38 -0400
Received: from 22dyn160.com21.casema.net ([213.17.92.160]:15885 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S264728AbRFSTM1>;
	Tue, 19 Jun 2001 15:12:27 -0400
Date: Tue, 19 Jun 2001 21:10:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619211038.A3704@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com> <15151.30600.896238.78222@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15151.30600.896238.78222@pizda.ninka.net>; from davem@redhat.com on Tue, Jun 19, 2001 at 09:02:16AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 09:02:16AM -0700, David S. Miller wrote:
> 
> Dan Kegel writes:
>  > Alan, did you really say that, or are people taking your name in vain?
> 
> He did say it, and I for one agree with him. :-)

Which clearly marks you as a typical kernel-side developer :-) It never
ceases to amaze me how different a userland perspective can be from that of
people who live in kernel space.

You could write 'how many kernel developers does it take to screw in a
lightbulb'-type jokes I suspect. Except that sometimes it isn't funny

Alan may be right in stating that nothing beats userspace state machines in
the same number of processes as there are cpus, from an efficiency
standpoint.

But that foregoes the point that the code is far more complex and harder to
make 'obviously correct', a concept that *does* translate well to userspace.

Regards,

bert hubert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
