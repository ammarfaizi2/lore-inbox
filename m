Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVGKRSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVGKRSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVGKRRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:17:36 -0400
Received: from mail.mev.co.uk ([62.49.15.74]:43709 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S262229AbVGKROr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:14:47 -0400
Message-ID: <42D2A8F1.1050101@mev.co.uk>
Date: Mon, 11 Jul 2005 18:14:25 +0100
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 - USB Mouse not detected
References: <Pine.LNX.4.44L0.0507101638470.24579-100000@netrider.rowland.org> <200507101712.00181.kernel-stuff@comcast.net>
In-Reply-To: <200507101712.00181.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jul 2005 17:14:27.0037 (UTC) FILETIME=[FDDF00D0:01C5863B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2005 22:11, Parag Warudkar wrote:
> What's funny - I rebuilt hotplug - same version - and it works now! Probably 
> it was failing for some reason the first time.

Maybe the original version separated hotplugging from coldplugging and 
your rebuilt version doesn't.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
