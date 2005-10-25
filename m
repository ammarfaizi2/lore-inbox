Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVJYXTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVJYXTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVJYXTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:19:01 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:26571 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S932473AbVJYXTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:19:00 -0400
Message-ID: <435EBD56.70601@cantab.net>
Date: Wed, 26 Oct 2005 00:18:46 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Dooks <ben@fluff.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sharp zaurus: prevent killing spitz-en
References: <20051025190829.GA1788@elf.ucw.cz> <20051025225815.GA31679@home.fluff.org>
In-Reply-To: <20051025225815.GA31679@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> 
> It would be better for each machine to export an config option
> from the Kconfig to specify if they have a maximum size.

Isn't the maximum size a property of the bootloader/other firmware? 
i.e., something the kernel build system knows nothing about.

David Vrabel
