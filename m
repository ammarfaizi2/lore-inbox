Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317291AbSFGOfm>; Fri, 7 Jun 2002 10:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317292AbSFGOfl>; Fri, 7 Jun 2002 10:35:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39421 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317291AbSFGOfk>; Fri, 7 Jun 2002 10:35:40 -0400
Subject: Re: PDC20267 + RAID can't find raid device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1023391095.3423.112.camel@flory.corp.rackablelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Jun 2002 16:28:47 +0100
Message-Id: <1023463727.25522.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 20:18, Samuel Flory wrote:
>   One major issue for me is that you can use, and mount both the
> /dev/ataraid/d0 devices, and the /dev/hd devices.  This makes for lots
> of fun in the Red Hat installer, and Cerberus.   

Stupidity management for the superuser is a user space issue in Unix
systems. If the RH installer does let you do stupid things, please
bugzilla it.

