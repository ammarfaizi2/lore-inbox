Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbUKKW6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUKKW6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKKW4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:56:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262419AbUKKWvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:51:36 -0500
Message-ID: <4193ECEC.2010606@pobox.com>
Date: Thu, 11 Nov 2004 17:51:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: network interface to driver and pci slot mapping
References: <8874763604111113281b1cf9a5@mail.gmail.com> <Pine.LNX.4.61.0411111640470.11012@chaos.analogic.com> <yw1xhdnwnhfi.fsf@ford.inprovide.com>
In-Reply-To: <yw1xhdnwnhfi.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> linux-os <linux-os@chaos.analogic.com> writes:
> 
> 
>>If the eth0 device is a module, it's in /etc/modprobe.conf, previous
>>versions used /etc/modules.conf.
>>Once you have its module name you can use other resources like
>>
>>/sys/bus/pci/drivers/MODULENAME
> 
> 
> On my systems, hotplug loads the modules automatically, so there is
> no mention of them anywhere.

Use ethtool.

	Jeff



