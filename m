Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265624AbSJXTv2>; Thu, 24 Oct 2002 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbSJXTv2>; Thu, 24 Oct 2002 15:51:28 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:1664 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265624AbSJXTv2>; Thu, 24 Oct 2002 15:51:28 -0400
Date: Thu, 24 Oct 2002 15:53:49 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: ebuddington@wesleyan.edu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44-ac2: stack overflow in acpi_initialize_objects
Message-ID: <20021024155349.A217@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
References: <20021024102034.A102@ma-northadams1b-3.bur.adelphia.net> <1035478619.9081.17.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1035478619.9081.17.camel@nighthawk>; from haveblue@us.ibm.com on Thu, Oct 24, 2002 at 09:56:59AM -0700
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 09:56:59AM -0700, David C. Hansen wrote:
> On Thu, 2002-10-24 at 07:20, Eric Buddington wrote:
> > 2.5.44-ac2 compiled for Athlon with gcc-3.2 fails to boot with a
> > really exciting stack overflow that dumps hordes of stack trace on the
> > screen. I'm too lazy to write it all down, but the last line before
> > 'init' refers to acpi_initialize_objects.
> 
> Does it panic, or just print out a lot of the traces?  

It panics, and yes, it's a very long list (So I can't tell what's at
the top of it). I'm trying to get a proper record via serial-console,
but can't find my adapters. I'll post it as soon as I can get it...

-Eric
