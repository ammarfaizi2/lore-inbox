Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUG0UQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUG0UQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUG0UQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:16:35 -0400
Received: from mail.hardcore-gaming.net ([69.93.101.157]:5015 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S266613AbUG0UOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:14:35 -0400
Message-ID: <4106C5B7.9040606@clanhk.org>
Date: Tue, 27 Jul 2004 15:14:31 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@austin.ibm.com>,
       Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com> <41067543.3090003@pobox.com>
In-Reply-To: <41067543.3090003@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Why do you think libata is not already hotplug capable, WRT controllers?

I'm not sure what WRT means, but your last Linux SATA Update did contain:

"Hotplug support
---------------
All SATA is hotplug.

libata does not support hotplug... yet.

The following SATA controllers will never support hotplug:
Intel ICH5, Intel ICH5-R, Intel ICH6 (non-AHCI), Pacific Digital Talon,
Promise SATA SX4."

-ryan



