Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSDGK4k>; Sun, 7 Apr 2002 06:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313089AbSDGK4j>; Sun, 7 Apr 2002 06:56:39 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:29959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313087AbSDGK4j>; Sun, 7 Apr 2002 06:56:39 -0400
Date: Sun, 7 Apr 2002 11:56:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
Message-ID: <20020407115632.C30048@flint.arm.linux.org.uk>
In-Reply-To: <20020407112716.A30048@flint.arm.linux.org.uk> <Pine.GSO.4.21.0204071239310.2567-100000@lisianthus.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 12:42:45PM +0200, Geert Uytterhoeven wrote:
> Perhaps you want to modularize the driver later? Resource management also
> prevents you from insmoding two drivers for the same hardware.

I doubt I'll be doing anything with those two drivers - up to other
people.  I'm prodding them now, but not expecting any immediate
reaction.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

