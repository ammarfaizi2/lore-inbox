Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWALUzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWALUzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWALUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:55:35 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32995 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161090AbWALUze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:55:34 -0500
Message-ID: <43C6C23A.3080402@pobox.com>
Date: Thu, 12 Jan 2006 15:55:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
References: <20060109203711.GA25023@kroah.com>	 <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>	 <20060109164410.3304a0f6.akpm@osdl.org> <1136857742.14532.0.camel@localhost.localdomain>
In-Reply-To: <1136857742.14532.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > On Llu, 2006-01-09 at 16:44 -0800,
	Andrew Morton wrote: > >>- Reuben Farrelly's oops in make_class_name().
	Could be libata, or scsi >> or driver core. > > > libata I think. I
	reproduced it on 2.6.14-mm2 by accident with a buggy > pata driver.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-01-09 at 16:44 -0800, Andrew Morton wrote:
> 
>>- Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
>>  or driver core.
> 
> 
> libata I think. I reproduced it on 2.6.14-mm2 by accident with a buggy
> pata driver.


Any additional info?  How can I reproduce?

	Jeff

