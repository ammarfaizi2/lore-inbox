Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRCBPz1>; Fri, 2 Mar 2001 10:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRCBPzR>; Fri, 2 Mar 2001 10:55:17 -0500
Received: from [195.65.218.116] ([195.65.218.116]:16097 "EHLO
	uxmailstest.stest.ch") by vger.kernel.org with ESMTP
	id <S129276AbRCBPzK>; Fri, 2 Mar 2001 10:55:10 -0500
Message-ID: <3A9FC1F0.B840B0F8@pop.agri.ch>
Date: Fri, 02 Mar 2001 16:53:27 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
Organization: zero
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Daniel.Stutz@astaro.de
CC: linux-kernel@vger.kernel.org
Subject: Re: PPP bug in 2.4.1-ac20 ?
In-Reply-To: <20010301184528.B663@mukmin.astaro.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Stutz wrote:
> 
> pppd version is 2.3.11
> 
> In all 2.4.1 versions pppd exits with something like:
>         ioctl(PPPIOFLAGS): invalid argument
> 
> I don't know if this is fixed in a 2.4.2 version.
> I don't even know if this is not a pppd bug.

Update pppd to version 2.4.x e.g from ftp.linuxcare.com/pub/ppp

Andreas
