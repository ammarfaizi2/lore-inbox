Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbRASTAW>; Fri, 19 Jan 2001 14:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132967AbRASTAD>; Fri, 19 Jan 2001 14:00:03 -0500
Received: from 3dyn148.com21.casema.net ([212.64.94.148]:29203 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S132367AbRASS77>;
	Fri, 19 Jan 2001 13:59:59 -0500
Date: Fri, 19 Jan 2001 20:52:26 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119205226.B12031@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <OF50B8511C.DA424B45-ON852569D9.0061881B@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <OF50B8511C.DA424B45-ON852569D9.0061881B@pok.ibm.com>; from frankeh@us.ibm.com on Fri, Jan 19, 2001 at 01:03:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 01:03:05PM -0500, Hubertus Franke wrote:
> 
> Mike sounds good, we will do all our measurements from now on with thread
> count for the entire range from 1 to 16 and
> then in power of twos upto 2048 and for maxcpus=1,2,4,6,8. Do you think
> that 4096 is overkill ? So far the numbers you got and we got over here are
> the same. Andi suggested that <pre8> has some problems with IO scheduling.

I have used up to 3000 threads in serious non-frivolous programs. Although I
have since been flamed over at #kernelnewbies that I should have been using
a statemachine :-)

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
