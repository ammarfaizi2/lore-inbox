Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHWHZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHWHZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWHWHZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:25:54 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:48530 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S932376AbWHWHZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:25:53 -0400
Message-ID: <44EC02FD.7050207@tomt.net>
Date: Wed, 23 Aug 2006 09:25:49 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hardware vs. Software Raid Speed
References: <44EBFB3E.8070905@perkel.com>
In-Reply-To: <44EBFB3E.8070905@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0 
> striping on the motherboard. Just wondering if hardware raid (SATA2) 
> is going to be faster that software raid and why?

Beeing a consumer type board (AM2), the "raid on the motherboard" is in 
99.999% of the cases just software raid implemented in their Windows 
drivers, a bootup setup screen plus some BIOS magic to get the OS booting.
