Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTDMMS4 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTDMMS4 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:18:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263484AbTDMMSz (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:18:55 -0400
Date: Sun, 13 Apr 2003 13:30:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: iain@savagelandz.cjb.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI: Device 02:04.0 not available because of resource collisions
Message-ID: <20030413133040.A855@flint.arm.linux.org.uk>
Mail-Followup-To: iain@savagelandz.cjb.net, linux-kernel@vger.kernel.org
References: <36716.192.18.240.6.1050229446.squirrel@savagelandz.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <36716.192.18.240.6.1050229446.squirrel@savagelandz.cjb.net>; from iain@savagelandz.cjb.net on Sun, Apr 13, 2003 at 11:24:06AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 11:24:06AM +0100, iain@savagelandz.cjb.net wrote:
> What other information do you need? I'm afraid I'm not really a programmer
> and the insides of the kernel are a bit beyond me.

The output of:

lspci -vv
cat /proc/iomem
cat /proc/ioports

from both a working and non-working kernel would be most helpful (along
with the kernel versions used.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

