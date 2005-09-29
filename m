Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVI2G3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVI2G3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVI2G3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:29:41 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:16852 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932085AbVI2G3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:29:40 -0400
Date: Thu, 29 Sep 2005 09:29:37 +0300
From: Ville Herva <vherva@vianova.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20050929062937.GY24719@viasys.com>
Reply-To: vherva@vianova.fi
References: <20050927111038.GA22172@ime.usp.br> <20050928084330.GC24760@viasys.com> <1127949809.26686.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127949809.26686.14.camel@localhost.localdomain>
X-Operating-System: Linux herkules.vianova.fi 2.4.27
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 12:23:28AM +0100, you [Alan Cox] wrote:
> On Mer, 2005-09-28 at 11:43 +0300, Ville Herva wrote:
> > I NEVER got the board stable, and ended up ditching it.
> > 
> > It seemed to be a KT133 Northbridge DMA issue. My impression is that KT133
> > is utter crap period.
> 
> It was a FIFO bug, but the kernel knows about it and it should handle
> this correctly. 

Interesting. Since which version?

> Is the hard disk running UDMA133 ?

The hardware has long since been ditched for good after months of vasted
effort to get it working, but I think HPT370 on KT7 supports UDMA100 at
maximum, and the disks were likely UDMA66. 



-- v -- 

v@iki.fi

