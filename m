Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135338AbRANTrc>; Sun, 14 Jan 2001 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135337AbRANTrX>; Sun, 14 Jan 2001 14:47:23 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:45320 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S135333AbRANTrN>; Sun, 14 Jan 2001 14:47:13 -0500
Date: Sun, 14 Jan 2001 20:46:57 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Robert J. Bell" <rob@bellfamily.org>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
Message-ID: <20010114204657.B17160@pcep-jamie.cern.ch>
In-Reply-To: <3A5F8956.9040305@bellfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F8956.9040305@bellfamily.org>; from rob@bellfamily.org on Fri, Jan 12, 2001 at 02:46:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert J. Bell wrote:
> I have a Fujufilm FX-1400 digital camera that uses the USB Mass Storage 
> driver. I know it works because I had it working in 2.4.0-test12, and in 
> 2.4.0 however I had a major system failure and lost my new kernel. 

Fwiw, I have a Fujifilm FinePix 2400Zoom and it appears to be working
fine with the USB Mass Storage driver from 2.4.0.  I used the uhci.c
driver to test, even though I normally use the usb-uhci.c driver when
I'm using my USB modem.  No reason, I just forgot which one I normally
use :-)

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
