Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbTCLPlD>; Wed, 12 Mar 2003 10:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbTCLPlC>; Wed, 12 Mar 2003 10:41:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261740AbTCLPk2>;
	Wed, 12 Mar 2003 10:40:28 -0500
Date: Wed, 12 Mar 2003 16:51:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312155105.GJ834@suse.de>
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org> <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312154440.GA4868@win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Andries Brouwer wrote:
> On Wed, Mar 12, 2003 at 11:14:14AM +0100, Jens Axboe wrote:
> 
> > So I still think it's much better stick with the safe choice. Why do you
> > think it's only one drive that has this bug? It basically boils down to
> > whether That Other OS uses 256 sector commands or not. If it doesn't, I
> > wouldn't trust the drives one bit.
> 
> I am not quite sure I understand your reasoning.
> We have seen *zero* drives that do not understand 256 sector commands.
> Maybe such drives exist, but so far there is zero evidence.

Have you read the thread? You are obviously mistaken.

-- 
Jens Axboe

