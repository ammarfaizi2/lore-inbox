Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133089AbRDLJQK>; Thu, 12 Apr 2001 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbRDLJQA>; Thu, 12 Apr 2001 05:16:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S133083AbRDLJPv>;
	Thu, 12 Apr 2001 05:15:51 -0400
Date: Thu, 12 Apr 2001 10:06:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Steven Walter <srwalter@yahoo.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] serial ioctl not returning with 2.4.3
Message-ID: <20010412100640.A22907@flint.arm.linux.org.uk>
In-Reply-To: <20010411142538.A27290@hapablap.dyn.dhs.org> <3AD4C38D.2C970A60@mandrakesoft.com> <20010411173642.A29791@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411173642.A29791@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Wed, Apr 11, 2001 at 05:36:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 05:36:42PM -0500, Steven Walter wrote:
> It would appear that way, if not for something I neglected to mention in
> my first message--the ioctl is on the fd for the opened serial port.
> This succeeds in other version of the kernel (as described in my
> original posting) and so must somehow be valid for the serial driver.
> 
> Any more thoughts?  This would seem to be a definite bug in the serial
> code.

I've got an old copy of agetty here (about '95) which I'll try on 2.4.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

