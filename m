Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTFPHkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFPHkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:40:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263487AbTFPHkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:40:35 -0400
Date: Mon, 16 Jun 2003 08:54:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
Message-ID: <20030616085403.A5969@flint.arm.linux.org.uk>
Mail-Followup-To: Jaakko Niemi <liiwi@lonesom.pp.fi>,
	linux-kernel@vger.kernel.org
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi> <20030615191125.I5417@flint.arm.linux.org.uk> <87el1vcdrz.fsf@jumper.lonesom.pp.fi> <20030615212814.N5417@flint.arm.linux.org.uk> <87he6qc3bb.fsf@jumper.lonesom.pp.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87he6qc3bb.fsf@jumper.lonesom.pp.fi>; from liiwi@lonesom.pp.fi on Mon, Jun 16, 2003 at 02:46:00AM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 02:46:00AM +0300, Jaakko Niemi wrote:
> > Which kernel version first showed the problem?
> 
>  2.5.71-bk13 was the first I managed to notice this with, iirc.
>  If you have some older version in mind, I can try that. 

Which was the latest kernel version which didn't show the problem?
There doesn't seem to be any PCI, PCMCIA or driver model changes
from 2.5.70-bk12 to 2.5.70-bk13.

There are changes in:

	-bk11 (pci)
	-bk10 (pci)
	-bk9 (driver model)
	-bk4 (pci)
	-bk2 (pcmcia)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

