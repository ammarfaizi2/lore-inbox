Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272592AbRI3GBj>; Sun, 30 Sep 2001 02:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272619AbRI3GB3>; Sun, 30 Sep 2001 02:01:29 -0400
Received: from h183n3fls22o974.telia.com ([213.64.105.183]:45458 "EHLO
	milou.dyndns.org") by vger.kernel.org with ESMTP id <S272592AbRI3GBM>;
	Sun, 30 Sep 2001 02:01:12 -0400
Message-Id: <200109300601.f8U61aR16372@milou.dyndns.org>
X-Mailer: exmh version 2.5_20010923 01/15/2001 with nmh-1.0.4
To: Andre Hedrick <andre@aslab.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC (patch below) Re: ide drive problem? 
In-Reply-To: Message from Andre Hedrick <andre@aslab.com> 
   of "Sat, 29 Sep 2001 15:21:29 PDT." <Pine.LNX.4.31.0109291520250.8143-100000@postbox.aslab.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Sep 2001 08:01:35 +0200
From: Anders Eriksson <ander@milou.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> cat /proc/ide/hda/smart_values
> cat /proc/ide/hda/smart_thresholds
> 
> Does that work?
> 

Yes. Or at least I think so. I get get two chunks of numbers, most of which are zeros. What's their meaning?

The bios says smart is disabled yet I get these values, any correlation?

/Anders

