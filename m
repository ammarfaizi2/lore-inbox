Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270181AbRHGKxJ>; Tue, 7 Aug 2001 06:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270182AbRHGKw7>; Tue, 7 Aug 2001 06:52:59 -0400
Received: from customers.imt.ru ([212.16.0.33]:26885 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id <S270181AbRHGKwn>;
	Tue, 7 Aug 2001 06:52:43 -0400
Message-ID: <20010807034810.A10311@saw.sw.com.sg>
Date: Tue, 7 Aug 2001 03:48:10 -0700
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Joseph Cheek <joseph@cheek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <20010806022727.A25793@saw.sw.com.sg> <Pine.LNX.4.10.10108060846230.14815-100000@chicago.cheek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.10.10108060846230.14815-100000@chicago.cheek.com>; from "Joseph Cheek" on Mon, Aug 06, 2001 at 08:48:22AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 08:48:22AM -0700, Joseph Cheek wrote:
> i applied the usleep(1) patch and i still get lockups on 2.4.7-ac5.  not
> sure how i could get you the info you need, but i would certainly be
> willing to help.
> 
> my machine locks hard before anything gets to syslog.

Are you able to check the screen?
Had the driver printed anything before the lockup?

	Andrey
