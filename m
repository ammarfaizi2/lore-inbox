Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRIDVEO>; Tue, 4 Sep 2001 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbRIDVED>; Tue, 4 Sep 2001 17:04:03 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:56075 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269223AbRIDVDt>; Tue, 4 Sep 2001 17:03:49 -0400
Date: Tue, 4 Sep 2001 23:03:53 +0200
From: Cliff Albert <cliff@oisec.net>
To: "C. Linus Hicks" <lhicks@nc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord with LSI53C1010 and Yamaha CRW2100S
Message-ID: <20010904230353.A22557@oisec.net>
Mail-Followup-To: "C. Linus Hicks" <lhicks@nc.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <999636520.5244.146.camel@lh2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999636520.5244.146.camel@lh2>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 04:48:40PM -0400, C. Linus Hicks wrote:

> I have been unsuccessful trying to burn a CD-R since upgrading my
> computer and I'm not sure where to go with this. I decided to try here.
> I suspect a problem with the SYM53C8xx driver, and I think there may
> also be additional problems elsewhere. My old system worked. It was:
> 
> RedHat 7.0 with 2.2.19 kernel
> ASUS P2B-DS (440BX chipset) with 2 600MHz Intel processors
> On-board Adaptec AIC-7890 with the new aic7xxx driver
> Add-on Adaptec 2940 PCI adapter (narrow devices attached here)
> Yamaha CRW6416S CD writer
> 
> My new system:
> 
> RedHat 7.1 with 2.4.8-ac11 kernel
> Tyan Thunder HEsl S2567 (ServerWorks chipset) with 2 1000MHz Intel
> processors
> On-board LSI 53C1010-66 (running at 33MHz) dual channel SCSI
> Add-on LSI21003 with 53C1010-33 (narrow devices here)
> SYM53C8xx driver
> Yamaha CRW2100S CD writer
> 
> I looked for problem reports with the 2100S and didn't see any, rather
> several reports that it worked okay. I updated the firmware to the
> latest - 1.0N and it didn't help.

I can affirm that the CRW2100S is not the problem as it's been working
correctly on my P2B-S (AIC7890). The CRW2100S has firmware 1.0H.

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
