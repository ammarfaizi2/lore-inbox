Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUE2MYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUE2MYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUE2MYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:24:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61201 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264360AbUE2MYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:24:06 -0400
Date: Sat, 29 May 2004 13:23:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Artemio <theman@artemio.net>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] let IEEE1394 select NET
Message-ID: <20040529132356.A3014@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Artemio <theman@artemio.net>, bcollins@debian.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <200405291424.43982.theman@artemio.net> <20040529121408.GM16099@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040529121408.GM16099@fs.tum.de>; from bunk@fs.tum.de on Sat, May 29, 2004 at 02:14:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 02:14:08PM +0200, Adrian Bunk wrote:
> The following patch lets FireWire support automatically select 
> Networking support:

And so we get another fscking symbol which has a non-obvious way to
turn it off.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
