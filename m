Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRD1W0O>; Sat, 28 Apr 2001 18:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRD1W0D>; Sat, 28 Apr 2001 18:26:03 -0400
Received: from 20dyn46.com21.casema.net ([213.17.90.46]:38668 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131643AbRD1WZn>;
	Sat, 28 Apr 2001 18:25:43 -0400
Date: Sun, 29 Apr 2001 01:16:04 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
Message-ID: <20010429011604.A976@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.33.0104281402090.2487-100000@age.cs.columbia.edu>; from ionut@cs.columbia.edu on Sat, Apr 28, 2001 at 02:21:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 02:21:29PM -0700, Ion Badulescu wrote:
> Hi Alan,
> 
> Over the last week I've tried to upgrade a 4-CPU Xeon box to 2.2.19, but 
> the it keeps locking up whenever the disks are stresses a bit, e.g. when 
> updatedb is running. I get the following messages on the console:
> 
> wait_on_bh, CPU 1:
> irq:  1 [1 0]
> bh:   1 [1 0]
> <[8010af71]>

Obvious question is, which compiler.

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
