Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSGYNSP>; Thu, 25 Jul 2002 09:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNSP>; Thu, 25 Jul 2002 09:18:15 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47626
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313416AbSGYNSL>; Thu, 25 Jul 2002 09:18:11 -0400
Date: Thu, 25 Jul 2002 06:16:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Samuel Thibault <samuel.thibault@fnac.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, martin@dalecki.de
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <Pine.LNX.4.10.10207251501580.505-100000@bureau.famille.thibault.fr>
Message-ID: <Pine.LNX.4.10.10207250615040.4719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Samuel Thibault wrote:

> 
> On Wed, 24 Jul 2002, Andre Hedrick wrote:
> 
> > You just dropped IO sync with the main loop, it is a dead dog.
> 
> Why sync with the main loop ?

I am sorry, I sent this offline where it was intended to be!

Cheers,

Andre Hedrick
LAD Storage Consulting Group

