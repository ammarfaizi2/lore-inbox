Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCHWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCHWNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCHWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:13:30 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9608 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261539AbVCHWM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:12:57 -0500
Message-ID: <422E24A8.4070504@tmr.com>
Date: Tue, 08 Mar 2005 17:18:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg K-H <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
References: <11099696383203@kroah.com> <11099696391236@kroah.com>
In-Reply-To: <11099696391236@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> 
> [PATCH] PCI: One more Asus SMBus quirk
> 
> One more Asus laptop requiring the SMBus quirk (W1N model).
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Hopefully this and the double-free patch will be included in 2.6.11.n+1? 
They seem to fit the "real bug" criteria.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
