Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318937AbSH1UP1>; Wed, 28 Aug 2002 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSH1UP1>; Wed, 28 Aug 2002 16:15:27 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:65357 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S318937AbSH1UP0>; Wed, 28 Aug 2002 16:15:26 -0400
Date: Wed, 28 Aug 2002 22:24:25 +0200
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: Greg KH <greg@kroah.com>
Cc: Luca Barbieri <ldb@ldb.ods.org>, petkan@users.sourceforge.net,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020828222425.D451@jeroen.pe1rxq.ampr.org>
References: <1030232838.1451.99.camel@ldb> <20020826162204.GB17819@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020826162204.GB17819@kroah.com>; from greg@kroah.com on Mon, Aug 26, 2002 at 18:22:05 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.08.26 18:22:05 +0200 Greg KH wrote:
> On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> > ./drivers/usb/media/se401.h
> 
> Should be fixed, Jeroen, do you want to do this?

Ok, already located the cause, I will check the other inlines to and send a
patch.

Jeroen


