Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSDNMyy>; Sun, 14 Apr 2002 08:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSDNMyx>; Sun, 14 Apr 2002 08:54:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19982 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312253AbSDNMyw>; Sun, 14 Apr 2002 08:54:52 -0400
Date: Sun, 14 Apr 2002 13:54:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another compile error with 2.4.19-pre6aa1
Message-ID: <20020414135446.B31359@flint.arm.linux.org.uk>
In-Reply-To: <20020414124101.1434.qmail@web10401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 10:41:01PM +1000, Steve Kieu wrote:
> Me again, after unselect the Texas Instrument PCILynx
> support in config I proceed the make modules and this
> time I got.

Marcelo missed pulling my BK tree with the fix for this - it should
be fixed in the latest 2.4.19 tree.  If not, let me know (I've not been
following 2.4.19 the past week.)

Just disable the SA1100 PCMCIA option for now.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

