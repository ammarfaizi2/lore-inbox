Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUITSAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUITSAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUITSAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:00:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266891AbUITR7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 13:59:54 -0400
Message-ID: <414F1A8C.10803@pobox.com>
Date: Mon, 20 Sep 2004 13:59:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Andy Lutomirski <luto@myrealbox.com>, Hans-Frieder Vogt <hfvogt@arcor.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot
 (FIX included)
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com> <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com> <20040917160151.GA29337@electric-eye.fr.zoreil.com> <414DF773.7060402@myrealbox.com> <20040919213952.GA32570@electric-eye.fr.zoreil.com> <414E46F1.9050309@pobox.com> <20040920071743.GA7115@electric-eye.fr.zoreil.com>
In-Reply-To: <20040920071743.GA7115@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>That sounds like a bug right there...  need all the addresses set up 
>>before we turn on stuff.
> 
> 
> The description of the CPlusCmd in the 8169 datasheet includes a small note
> which suggests that this register should be set up early.
> 
> It does not cost much to try and see if it makes a difference for DAC though.

Let me know what happens :)

	Jeff



