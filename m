Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVBNUBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVBNUBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBNUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 15:01:10 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:19081 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S261551AbVBNUAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 15:00:41 -0500
Message-ID: <42110359.1050301@unre.st>
Date: Mon, 14 Feb 2005 15:00:25 -0500
From: "Michael J. Cohen" <mjc@unre.st>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20050131)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan <alan@clueserver.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Odd problem with dual processor AMD system
References: <1108372774.1107.13.camel@dagon.fnordora.org>
In-Reply-To: <1108372774.1107.13.camel@dagon.fnordora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:

>Ideas on how to log something that early in the boot process without
>being in front of the machine?
>
Serial console is best.  remote power cycle, grub, and serial console 
make my life easier every day of the week.

Also it would help for the other issues if you'd post a .config and 
perhaps the rest of your dmesg to the lkml, though if gets to be fairly 
large doing so on the web would be best.

HTH,
Michael

