Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJMSzQ>; Sun, 13 Oct 2002 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJMSzQ>; Sun, 13 Oct 2002 14:55:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12036 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261578AbSJMSzQ>; Sun, 13 Oct 2002 14:55:16 -0400
Date: Sun, 13 Oct 2002 20:01:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021013200104.C23142@flint.arm.linux.org.uk>
References: <20021013194041.A15609@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021013194041.A15609@medelec.uia.ac.be>; from wim@iguana.be on Sun, Oct 13, 2002 at 07:40:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 07:40:41PM +0200, Wim Van Sebroeck wrote:
> I'm reviewing the different watchdog drivers and started porting the features 
> that have been added in the 2.4 kernel to the 2.5 development kernel.
> I now wondered if it would make sence to put all watchdog drivers in
> drivers/char/watchdog/ instead of in drivers/char ?
> Please comments.

Rob Radez has been doing a lot of work in this area; I thought he
was going to do the 2.5 drivers as well (or his last mail on the
8 August seemed to imply that.)  Not sure what happened.

Rob?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

