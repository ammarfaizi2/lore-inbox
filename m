Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbVLJCmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbVLJCmC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVLJCmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:42:01 -0500
Received: from mail.dvmed.net ([216.237.124.58]:57525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932710AbVLJCmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:42:00 -0500
Message-ID: <439A4070.2000500@pobox.com>
Date: Fri, 09 Dec 2005 21:41:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com> <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com> <20051209122457.GB26070@srcf.ucam.org> <439A23E8.3080407@pobox.com> <20051210023426.GA31220@srcf.ucam.org>
In-Reply-To: <20051210023426.GA31220@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Matthew Garrett wrote: > ACPI allows us to detect
	hotplug on ICH5, which sounds like a good > argument for its inclusion.
	Do you even know if this special case is applicable outside of Dell
	ICH5 boxes? And I thought your previous messages were referring to
	ICH6? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> ACPI allows us to detect hotplug on ICH5, which sounds like a good 
> argument for its inclusion.

Do you even know if this special case is applicable outside of Dell ICH5 
boxes?  And I thought your previous messages were referring to ICH6?

This is sounding more and more like a special-case-of-a-special-case.

	Jeff


