Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbSJZOBU>; Sat, 26 Oct 2002 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSJZOBU>; Sat, 26 Oct 2002 10:01:20 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54474 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261396AbSJZOBT>; Sat, 26 Oct 2002 10:01:19 -0400
Subject: Re: [PATCH] de-cryptify ide-disk host protected area output
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: bert hubert <ahu@ds9a.nl>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021026132419.GA11930@codepoet.org>
References: <20021026130701.GA29860@outpost.ds9a.nl> 
	<20021026132419.GA11930@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 15:25:21 +0100
Message-Id: <1035642321.12995.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 14:24, Erik Andersen wrote:
> Even better -- kill the prink entirely.  If anyone really
> cares, they can run 'hdparm -I <drivename>' and get the
> exhaustive list of everything the drive supports....

Please leave it alone for now. There are a whole collection of extremely
verbose and pointless IDE messages left, and I want them left until we
are close to release, so we can debug stuff

In fact I will probably add more very soon

