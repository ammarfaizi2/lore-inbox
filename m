Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCUTGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 14:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCUTGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 14:06:20 -0500
Received: from calvin.stupendous.org ([213.84.70.4]:59408 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S261181AbUCUTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 14:06:19 -0500
Date: Sun, 21 Mar 2004 20:06:17 +0100
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI Shutdown 2.6.3
Message-ID: <20040321190617.GA5650@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <405DADAC.9010601@dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405DADAC.9010601@dolda2000.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 09:58:52AM -0500, Bruce Park wrote:

> I'm experiencing a problem with ACPI and it's ability to shutdown the 
> machine. I'm currently using Debian GNU/Linux with the 2.6.3 kernel. Before 

If you boot with the "nolapic" option, does the machine poweroff correctly
then?

(This is the case on my Thinkpad T41 - 2.6.x doesn't powerdown unless I
boot with "nolapic")

-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance." - 308417
