Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280894AbRKGSIs>; Wed, 7 Nov 2001 13:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280893AbRKGSIi>; Wed, 7 Nov 2001 13:08:38 -0500
Received: from [212.18.232.186] ([212.18.232.186]:57351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S280892AbRKGSI3>; Wed, 7 Nov 2001 13:08:29 -0500
Date: Wed, 7 Nov 2001 18:08:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Error in ARM configuration (2.4.13)
Message-ID: <20011107180816.C26438@flint.arm.linux.org.uk>
In-Reply-To: <Pine.BSF.4.40.0111071806410.1128-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.BSF.4.40.0111071806410.1128-100000@fest.stud.fee.vutbr.cz>; from xkaspa06@stud.fee.vutbr.cz on Wed, Nov 07, 2001 at 06:36:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 06:36:33PM +0100, Kasparek Tomas wrote:
> There is no directory named "ssi" anywhere. So is it misstypo or
> should it be removed. Really, the first aid is to comment it out.

Why do this when the code hasn't been merged?  If you want to build for
ARM, please get the -rmk patch first.  Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

