Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281103AbRK3XHJ>; Fri, 30 Nov 2001 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281160AbRK3XHC>; Fri, 30 Nov 2001 18:07:02 -0500
Received: from [212.18.232.186] ([212.18.232.186]:53254 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281158AbRK3XGv>; Fri, 30 Nov 2001 18:06:51 -0500
Date: Fri, 30 Nov 2001 23:06:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: BALBIR SINGH <balbir.singh@wipro.com>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011130230634.G19193@flint.arm.linux.org.uk>
In-Reply-To: <20011129160637.50471.qmail@web13606.mail.yahoo.com> <20011129161756.D6214@flint.arm.linux.org.uk> <3C070A4D.7000708@wipro.com> <20011130141920.D504@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011130141920.D504@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Fri, Nov 30, 2001 at 02:19:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 02:19:20PM -0800, Mike Fedyk wrote:
> On Fri, Nov 30, 2001 at 09:55:49AM +0530, BALBIR SINGH wrote:
> > As you say this fix works for 2.4, Since we are into 2.5, I hope
> > that it will be fixed in a better manner in 2.5. I have some suggestions,
> > ideas for the serial driver in 2.5, are u willing to discuss them?
> > 
> 
> Would it not be better if the current code in 2.5 had the fix from 2.4 until
> the entire layer is audited?

That was my original intention.  IIRC, James Simmons has said he's rewriting
the tty layer anyway in 2.5.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

