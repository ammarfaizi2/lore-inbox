Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbULPTeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbULPTeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbULPTeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:34:10 -0500
Received: from mail.tmr.com ([216.238.38.203]:58129 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262006AbULPTeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:34:05 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: WHOOPS - linux-2.6.10-rc3 fails on ata_piix module
Date: Thu, 16 Dec 2004 14:35:22 -0500
Organization: TMR Associates, Inc
Message-ID: <41C1E37A.1030804@tmr.com>
References: <41BA5EAF.4090908@xmission.com><41BA5EAF.4090908@xmission.com> <41BAABDF.3020709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1103225074 23375 192.168.12.100 (16 Dec 2004 19:24:34 GMT)
X-Complaints-To: abuse@tmr.com
Cc: maxer1 <maxer1@xmission.com>, linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <41BAABDF.3020709@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> maxer1 wrote:
> 
>> WARNING: No module ata_piix found for kernel 2.6.10-rc3, continuing 
>> anyway
>> 2.6.9 works great here.
>> What is wrong here?
> 
> 
> Mainly a distinct lack of information in your bug report.  See 
> REPORTING-BUGS in the kernel source tree for information.
> 
> The ata_piix driver certainly didn't go away...

Perhaps the config requirements to cause it to build have changed?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
