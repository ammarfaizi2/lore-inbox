Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318135AbSGRPdB>; Thu, 18 Jul 2002 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSGRPdB>; Thu, 18 Jul 2002 11:33:01 -0400
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:3257 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S318135AbSGRPdB>;
	Thu, 18 Jul 2002 11:33:01 -0400
Date: Thu, 18 Jul 2002 09:36:11 -0600 (MDT)
From: Chris Ricker <kaboom@gatech.edu>
X-X-Sender: kaboom@hanuman.oobleck.net
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: devik <devik@cdi.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 is not SMP friendly
In-Reply-To: <1026999905.9727.13.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207180934310.1807-100000@hanuman.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Alan Cox wrote:

> On Thu, 2002-07-18 at 11:51, devik wrote:
> > I someone here running 2.4.18 on PII SMP successfully ?
> 
> PPro in my case but yes. 2.4.18 ought to be pretty solid except for some
> annoying bugs you'll only hit if you use smbfs. 

Or if you use data=journal w/ ext3....

later,
chris


