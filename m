Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313098AbSDGLLn>; Sun, 7 Apr 2002 07:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313121AbSDGLLm>; Sun, 7 Apr 2002 07:11:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313098AbSDGLLm>; Sun, 7 Apr 2002 07:11:42 -0400
Date: Sun, 7 Apr 2002 12:11:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre6 dead Makefile entries
Message-ID: <20020407121132.E30048@flint.arm.linux.org.uk>
In-Reply-To: <27694.1018177299@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 09:01:39PM +1000, Keith Owens wrote:
> lib/Makefile                    crc32.o

crc32.c seems to exist in linux/lib/ in 2.5.7 and 2.5.8-pre2

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

