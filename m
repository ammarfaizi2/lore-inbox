Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266583AbRGJPlc>; Tue, 10 Jul 2001 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266591AbRGJPlW>; Tue, 10 Jul 2001 11:41:22 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:25103 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S266583AbRGJPlP>;
	Tue, 10 Jul 2001 11:41:15 -0400
Date: Tue, 10 Jul 2001 09:41:13 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Bogomips Replacement
Message-ID: <20010710094113.B22905@qcc.sk.ca>
In-Reply-To: <20010710102935.5b5d6cfb.warthawg@ecpi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010710102935.5b5d6cfb.warthawg@ecpi.com>; from warthawg@ecpi.com on Tue, Jul 10, 2001 at 10:29:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Barr <warthawg@ecpi.com> wrote:

> What I want to do is rip out the bogomips code and replace it with something
> completely different.  Does anyone know who currently maintains it?  As I
> recall from the Geek Bowl earlier this year in NYC, nobody really knows what
> that bogomips stuff does anyway. 

The bogomips code is used to calibrate a timing loop which is used in various
drivers and other places.  Where did you get the idea that nobody knows this?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
