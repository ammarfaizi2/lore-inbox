Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAMGt1>; Sat, 13 Jan 2001 01:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRAMGtH>; Sat, 13 Jan 2001 01:49:07 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47116 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129562AbRAMGtA>; Sat, 13 Jan 2001 01:49:00 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 13 Jan 2001 17:46:31 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: Updated zerocopy patch up on kernel.org
Message-ID: <20010113174630.B17761@linuxcare.com>
In-Reply-To: <200101100055.QAA07674@pizda.ninka.net> <Pine.LNX.4.30.0101111137360.981-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101111137360.981-100000@e2>; from mingo@elte.hu on Thu, Jan 11, 2001 at 11:38:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > Nothing interesting or new, just merges up with the latest 2.4.1-pre1
> > patch from Linus.
> >
> > ftp.kernel.org:/pub/linux/kernel/people/davem/zerocopy-2.4.1p1-1.diff.gz
> >
> > I haven't had any reports from anyone, which must mean that it is
> > working perfectly fine and adds no new bugs, testers are thus in
> > nirvana and thus have nothing to report.  :-)
> 
> (works like a charm here.)

Likewise here running a sendfile hacked samba :)

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
