Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFNOis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFNOis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUFNOis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:38:48 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:19766 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263159AbUFNOip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:38:45 -0400
Message-ID: <40CDB871.6070408@microgate.com>
Date: Mon, 14 Jun 2004 09:38:41 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: areversat@tuxfamily.org
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Badness in local_bh_enable with eciadsl driver and kernel 2.6
References: <1087145610.2266.1.camel@hosts>	 <1087146654.2517.1.camel@doobie.pipehead.org> <1087221214.2270.6.camel@hosts>
In-Reply-To: <1087221214.2270.6.camel@hosts>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

areversat wrote:
> Ok someone tried the patch for me (i don't have the modem here). And it
> seems to work just fine : it removes the message i reported. It may need
> more extensive tests but it would be nice to think about including it to
> the kernel.

This patch is well tested and understood and I'm confident
it will be accepted. But Linus indicated 2.6.7-rc is closed
to new stuff so I have not pushed it to Andrew yet.

2.6.8 seems likely.

--
Paul Fulghum
paulkf@microgate.com
