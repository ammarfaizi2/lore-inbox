Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268831AbRG0KsF>; Fri, 27 Jul 2001 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268827AbRG0Kr4>; Fri, 27 Jul 2001 06:47:56 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:20930 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268824AbRG0Kro>; Fri, 27 Jul 2001 06:47:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Thomas Foerster <puckwork@madz.net>
Date: Fri, 27 Jul 2001 20:30:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15201.17117.641766.521810@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linx Kernel Source tree and metrics
In-Reply-To: message from Thomas Foerster on Friday July 27
In-Reply-To: <20010727095757Z268814-721+5010@vger.kernel.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday July 27, puckwork@madz.net wrote:
> Hi,
> 
> > "Paul G. Allen" wrote:
> 
> >> > > The URL is:
> >> >
> >> > > http://24.5.14.144:3000/linux-kernel
> >> >
> >> > [...]
> >> >
> >> > It's forwarded to "127.0.0.1:3000", so no one can connect?! ;-)
> >> >
> 
> > OK, try it now. (I really need another external IP/connection so I can
> > try these things out myself first :-)
> 
> http://keroon.dmz.dreampark.com:3000/linux-kernel/
> 
> Can't be found (DNS-Error)
> 

Just add a slash.  Then the webserver wont ahve to do it for you:

http://24.5.14.144:3000/linux-kernel/

> Thomas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
