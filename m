Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUFCGCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUFCGCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUFCGCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:02:04 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:8838 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265680AbUFCGB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:01:59 -0400
Message-ID: <40BEBED5.5000902@yahoo.com.au>
Date: Thu, 03 Jun 2004 16:01:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB interrupt is turned off after periods of inactivity
References: <40BD869F.402@yahoo.com.au> <20040602164912.GB7829@kroah.com>
In-Reply-To: <20040602164912.GB7829@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jun 02, 2004 at 05:49:51PM +1000, Nick Piggin wrote:
> 
>>Hello. I sent this to the USB devel list. No activity.
>>Let me know if I can get you more info or test anything.
> 
> 
> You didn't get a response probably because you are using the nvidia
> driver, and no kernel developer can help you then, sorry.
> 
> Try reproducing it without that driver loaded.
> 

I can't reproduce it with the latest -mm kernel and without the
nvidia driver.
