Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWAYVxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWAYVxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWAYVxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:53:07 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:53788 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S932108AbWAYVxG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:53:06 -0500
Date: Wed, 25 Jan 2006 22:48:52 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: Roger Heflin <rheflin@atipa.com>
cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Subject: RE: e1000_watchdog_task: NIC Link is Up/Down on kernels 2.4.15 2.4.14
In-Reply-To: <EXCHG2003KvPEkGhAj500000a0f@EXCHG2003.microtech-ks.com>
Message-ID: <Pine.LNX.4.64.0601252241060.25727@lt.wsisiz.edu.pl>
References: <EXCHG2003KvPEkGhAj500000a0f@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (portraits.wsisiz.edu.pl [127.0.0.1]); Wed, 25 Jan 2006 22:52:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Roger Heflin wrote:

about:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177043

> We have fixed a number of machines with this issue by adding a heatsink/fan
> near the ethernet chip, and we have got at least one MB manufacturer to
> duplicate
> the issue, and add a heat sink on their motherboads to correct the issue.

Thank You for sugestions. I will try to move this machine to another rack,
because i have find information about high temperature on
CPU in logs files.

Jan  1 04:03:21 w3cache kernel: CPU2: Running in modulated clock mode
Jan  1 04:03:21 w3cache kernel: CPU3: Running in modulated clock mode
Jan  1 04:03:26 w3cache kernel: CPU3: Temperature above threshold
Jan  1 04:03:26 w3cache kernel: CPU2: Temperature above threshold



-- 
£T
