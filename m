Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTD2LtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTD2LtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:49:18 -0400
Received: from [63.246.199.14] ([63.246.199.14]:3999 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S261754AbTD2LtR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:49:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: BTTV problems 2.4.20
Date: Tue, 29 Apr 2003 09:00:17 -0400
User-Agent: KMail/1.4.3
References: <200304290324.EAA04296@mauve.demon.co.uk>
In-Reply-To: <200304290324.EAA04296@mauve.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304290900.17310.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had several hauppage BT848 boards that did the same on several p4 & 
celeron PC's under 2.4.18.  I dumped them and got newer bt878 boards and the 
problem went away.

On Monday 28 April 2003 11:24 pm, root@mauve.demon.co.uk wrote:
> My hauppage BT848 card with the stock kernel driver seems to occasionally
> after reboot (warm, or poweroff under a few seconds) continue to write to
> memory.
> It's not the motherboard or RAM (changed from a PPRO 240, to a Duron 1300
> with different RAM).
> When this happens with the first motherboard, it failed POST (sometimes)
> and memtest would reveal memory errors in the top few meg of RAM.
> (16-40Mb of RAM installed)
>
> On the second motherboard, it unfortunately got past POST once, and
> proceeded to shred a filesystem when checking it.
> Any thoughts?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
