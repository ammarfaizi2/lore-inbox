Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129987AbRCGD4S>; Tue, 6 Mar 2001 22:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRCGD4H>; Tue, 6 Mar 2001 22:56:07 -0500
Received: from mail.lightband.com ([199.79.199.3]:15885 "EHLO
	mail.lightband.com") by vger.kernel.org with ESMTP
	id <S129987AbRCGDzw>; Tue, 6 Mar 2001 22:55:52 -0500
Message-ID: <20010307035507.14045.qmail@alongtheway.com>
Date: Wed, 7 Mar 2001 03:55:07 +0000
From: Jim Breton <jamesb-kernel@alongtheway.com>
To: linux-kernel@vger.kernel.org
Subject: Re: eject weirdness on NEC disc changer, kernel 2.4.2
In-Reply-To: <20010304205046.15690.qmail@alongtheway.com> <3AA3DE27.E34DD4B3@staffnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AA3DE27.E34DD4B3@staffnet.com>; from whampton@staffnet.com on Mon, Mar 05, 2001 at 01:42:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Hofmann (walter.hofmann@physik.stud.uni-erlangen.de)
Date: Mon Mar 05 2001 - 15:19:10 EST 

>> cancelling a burn session with cdrecord I am unable to eject the disc. 
>> However that was on kernel 2.2.x and using "real" scsi (not ide-scsi). 

>This was a bug in cdrecord which used generic scsi access to lock the 
>drive. The kernel cannot notice this. AFAIK this bug is fixed in 
>cdrecord. 

K, thanks.  I will have to upgrade once I figure out why my burner box
just beeps at me when I try to turn it on.  ;-\

So, anybody know what is up with the kernel?  :)  Again the issue I
originally posted about is a problem with standard ATAPI stuff (not
ide-scsi).
