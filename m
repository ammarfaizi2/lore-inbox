Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279741AbRKAU32>; Thu, 1 Nov 2001 15:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279743AbRKAU3H>; Thu, 1 Nov 2001 15:29:07 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:52639 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S279741AbRKAU2z>; Thu, 1 Nov 2001 15:28:55 -0500
Date: Thu, 1 Nov 2001 20:28:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Tim Waugh <twaugh@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
Message-ID: <20011101202846.E10819@flint.arm.linux.org.uk>
In-Reply-To: <3BE15BF0.C6FB873C@mandrakesoft.com> <Pine.LNX.4.10.10111011014500.2293-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111011014500.2293-100000@transvirtual.com>; from jsimmons@transvirtual.com on Thu, Nov 01, 2001 at 10:33:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 10:33:22AM -0800, James Simmons wrote:
> /drivers/serial 	-> Yes I plan a rewrite of the serial layer.

Correction - I plan a major cleanup of the serial layer.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

