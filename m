Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282185AbRK1Xnn>; Wed, 28 Nov 2001 18:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282197AbRK1Xms>; Wed, 28 Nov 2001 18:42:48 -0500
Received: from [212.18.232.186] ([212.18.232.186]:24333 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282190AbRK1Xkl>; Wed, 28 Nov 2001 18:40:41 -0500
Date: Wed, 28 Nov 2001 23:40:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Waltenberg <pwalten@au1.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011128234029.B2561@flint.arm.linux.org.uk>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>; from pwalten@au1.ibm.com on Thu, Nov 29, 2001 at 09:29:26AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 09:29:26AM +1000, Peter Waltenberg wrote:
> Someone who cares, come up with an indentrc for the kernel code, and get it
> into Documentation/CodingStyle
> If the maintainers run all new code through indent with that indentrc
> before checkin, the problem goes away.
> The only one who'll incur any pain then is a code submitter who didn't
> follow the rules. (Exactly the person we want to be in pain ;)).

See: linux/scripts/Lindent

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

