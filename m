Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132560AbRDGFrC>; Sat, 7 Apr 2001 01:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDGFqx>; Sat, 7 Apr 2001 01:46:53 -0400
Received: from cs.columbia.edu ([128.59.16.20]:13483 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S132577AbRDGFqp>;
	Sat, 7 Apr 2001 01:46:45 -0400
Date: Fri, 6 Apr 2001 22:46:17 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andre Hedrick <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.3 crashed my hard disk
In-Reply-To: <Pine.LNX.4.10.10104062237050.5964-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.30.0104062244510.14947-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Andre Hedrick wrote:

> > You really ought to rename this parameter to pcibus. Even though it doesn't
> > do justice to the VLB bus, the potential for user error is much smaller.
> 
> Until today you had a vaild point!
> 
> Promise Ultra100TX2 (20268 chipset).
> 
> This is a 66MHz clocked Ultra100 Chipset release this week.

Ok... but how does this invalidate my point? The 66MHz still applies to 
the PCI bus, so pcibus is ok for the parameter name, no?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

