Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266629AbTGFHbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbTGFHbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:31:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16657 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266629AbTGFHbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:31:03 -0400
Date: Sun, 6 Jul 2003 08:45:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Dominik Brodowski <linux@brodo.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Message-ID: <20030706084524.A8146@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	Daniel Ritz <daniel.ritz@gmx.ch>,
	Dominik Brodowski <linux@brodo.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200307060039.34263.daniel.ritz@gmx.ch> <200307061126.34635.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307061126.34635.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Sun, Jul 06, 2003 at 11:26:34AM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 11:26:34AM +0800, Michael Frank wrote:
> I got the patch below (not yet tested) from Dominik. 

I've already thrown this one out and suggested a cleaner alternative to
Dominik.

I was busy wasting time trying to get an XScale platform up and running
yesterday, and getting nowhere fast.  Going nowhere at all is a very
accurate description of yesterdays activities.  I suspect the hardware
may have been messed up during transit thanks to various screws missing.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

