Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136107AbRDVNXA>; Sun, 22 Apr 2001 09:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136109AbRDVNWu>; Sun, 22 Apr 2001 09:22:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40453 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136107AbRDVNWm>;
	Sun, 22 Apr 2001 09:22:42 -0400
Date: Sun, 22 Apr 2001 14:22:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Philip Blundell <philb@gnu.org>, junio@siamese.dhis.twinsun.com,
        Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
Message-ID: <20010422142224.D20807@flint.arm.linux.org.uk>
In-Reply-To: <E14rJTP-0005jL-00@kings-cross.london.uk.eu.org> <E14rJdU-0005p0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14rJdU-0005p0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 02:10:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 02:10:41PM +0100, Alan Cox wrote:
> 	Recommended
> 	-----------
> 	egcs-1.1.2		(miscompiles strstr  <2.4.4pre)
> 	gcc 2.95.*		(miscompiles strstr  <2.4.4pre)

Aren't both of these "miscompilation" problems are referring to the file
arch/i386/lib/strstr.c?  Therefore, its an x86 problem.  To use a phrase
that Linus uses, "its not an interesting problem" for the other
architectures.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

