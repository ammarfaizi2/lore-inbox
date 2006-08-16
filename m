Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWHPT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWHPT0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWHPT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:26:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:64937 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932184AbWHPT03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:26:29 -0400
X-Authenticated: #1347008
Message-ID: <44E3725D.3040208@gmx.net>
Date: Wed, 16 Aug 2006 21:30:37 +0200
From: Dirk <noisyb@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060503 Debian/1.7.8-1sarge6
X-Accept-Language: en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
References: <44E3552A.6010705@gmx.net> <20060816183707.GD13641@csclub.uwaterloo.ca>
In-Reply-To: <20060816183707.GD13641@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Wed, Aug 16, 2006 at 07:26:02PM +0200, Dirk wrote:
> 
>>I have changed a message that didn't clearly tell the user what was goin
>>on...
>>
>>Please have a look!
> 
> 
> Perhaps the real problem is that some @#$@#$ user space task is
> constantly trying to mount the disc while something else is trying to
> write to it.
> 
> gnome and kde both seem very eager to implement such things.  perhaps
> there should be a way to prevent any access by such processes while
> writing to the disc.
> 
> --
> Len Sorensen
> 
> 

I still use fvwm1 with _my_ config file unchanged for ~6 years now!!!

But you were right... after i removed some package called "hal"
everything works fine again...

must have been another trojan from the "Ready for the Desktop!" camp...

Dirk
