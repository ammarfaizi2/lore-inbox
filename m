Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSFJWfJ>; Mon, 10 Jun 2002 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316484AbSFJWfI>; Mon, 10 Jun 2002 18:35:08 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:10765 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316477AbSFJWfI>; Mon, 10 Jun 2002 18:35:08 -0400
Date: Mon, 10 Jun 2002 23:35:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 kill warnings 5/19
Message-ID: <20020610233501.E20585@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048D5A.1030103@evision-ventures.com> <20020610222438.GD22961@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 03:24:38PM -0700, William Lee Irwin III wrote:
> On Mon, Jun 10, 2002 at 01:28:26PM +0200, Martin Dalecki wrote:
> > Fix improper __FUNCTION__ usage in st680 driver code,
> > cdc-ether.c. Fix namespace clash in cdc-ether.h
> 
> Would you mind sending these as original posts and not as replies to
> Linus' announcement?

I'm sure the "reply" button is the only button some mail clients have.
Don't blame the people - blame the mail clients. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

