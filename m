Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVD0Hb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVD0Hb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0Hb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:31:57 -0400
Received: from mailgate1.mysql.com ([213.115.162.47]:56220 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261729AbVD0Hbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 03:31:55 -0400
Message-ID: <426F3FD1.3040007@mysql.com>
Date: Wed, 27 Apr 2005 09:31:29 +0200
From: Jonas Oreland <jonas.oreland@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert W. Fuller" <fullerrw@uindy.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TI Yenta socket Fish Please Report
References: <426F3A89.3010702@uindy.edu>
In-Reply-To: <426F3A89.3010702@uindy.edu>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert W. Fuller wrote:
> Hola,
> 
> Looks like I have the same problem that was discussed here in February 
> with PCI resources being assigned to the same range as RAM.  This is the 
> old thread: "IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no 
> PCIinterrupts. Fish. Please report.]"  I'm having this problem on 2.6.11.
> 
> Did the patch for this ever make it into the main kernel?  Is it still 
> in the -mm tree?  Will it ever be in the main kernel?  How do I figure 
> these things out?  Is there some bug database I can check?

I think it made it somehow.
I have a G40 which had the problem before I upgraded to 2.6.11

I however also had problem with a netgear wlan card.
And got a patch, that I haven't seen in any released kernel yet...

/Jonas

-- 
Jonas Oreland, Software Engineer
MySQL AB, www.mysql.com
