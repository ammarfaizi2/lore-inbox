Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSDEXMM>; Fri, 5 Apr 2002 18:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313697AbSDEXMC>; Fri, 5 Apr 2002 18:12:02 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:9934 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313690AbSDEXLx>; Fri, 5 Apr 2002 18:11:53 -0500
Message-Id: <200204052310.g35NAq518318@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: willy tarreau <wtarreau@yahoo.fr>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: faster boots?
Date: Sat, 6 Apr 2002 02:10:39 +0300
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020405132132.50285.qmail@web20512.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 April 2002 16:21 pm, willy tarreau wrote:
> > It's normally done with hdparm spindown when idle
> > options...
>
> only supported on IDE devices.
>
> Willy

There was a scsi_idle patch for spinning down scsi disks.
IIRC it was before 2.0 (for the 1.1.x or 1.2.x kernels). Anyone
know what happened with that patch and why it hasn't got into
the official kernel?
-- Itai
