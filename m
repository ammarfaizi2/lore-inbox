Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRCETJ6>; Mon, 5 Mar 2001 14:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRCETJs>; Mon, 5 Mar 2001 14:09:48 -0500
Received: from mail.lightband.com ([199.79.199.3]:51464 "EHLO
	mail.lightband.com") by vger.kernel.org with ESMTP
	id <S130324AbRCETJf>; Mon, 5 Mar 2001 14:09:35 -0500
Message-ID: <20010305190930.2759.qmail@alongtheway.com>
Date: Mon, 5 Mar 2001 19:09:30 +0000
From: Jim Breton <jamesb-kernel@alongtheway.com>
To: Wade Hampton <whampton@staffnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: eject weirdness on NEC disc changer, kernel 2.4.2
In-Reply-To: <20010304205046.15690.qmail@alongtheway.com> <3AA3DE27.E34DD4B3@staffnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AA3DE27.E34DD4B3@staffnet.com>; from whampton@staffnet.com on Mon, Mar 05, 2001 at 01:42:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 01:42:47PM -0500, Wade Hampton wrote:
> Have you had it where the drive would not eject the disc?  I seem 
> to be having this on several ATAPI drives (CD-R, CD-ROM, DVD), 
> all with ide-scsi running....

That particular issue has not happened to me.

I have had a similar problem in the past where, for example, after
cancelling a burn session with cdrecord I am unable to eject the disc.
However that was on kernel 2.2.x and using "real" scsi (not ide-scsi).

In the case of my original post, I am also not using ide-scsi, just
regular ide.
