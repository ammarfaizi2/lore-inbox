Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWAQTrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWAQTrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAQTrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:47:33 -0500
Received: from mail.dvmed.net ([216.237.124.58]:61870 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932417AbWAQTrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:47:32 -0500
Message-ID: <43CD49CE.7090806@pobox.com>
Date: Tue, 17 Jan 2006 14:47:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev list <netdev@oss.sgi.com>
Subject: Re: DE2104X
References: <43BED847.7040709@keyaccess.nl>
In-Reply-To: <43BED847.7040709@keyaccess.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Rene Herman wrote: > Hi Jeff. > > Upgraded a DEC Multia
	to 2.6 today and noticed its 21040 was split off > into the "de2104x"
	driver. Also see it's marked "experimental" and just > wanted to report
	that it seems to be working fine on the 21040 as found > in a DEC
	Multia (Pentium variant): [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Hi Jeff.
> 
> Upgraded a DEC Multia to 2.6 today and noticed its 21040 was split off 
> into the "de2104x" driver. Also see it's marked "experimental" and just 
> wanted to report that it seems to be working fine on the 21040 as found 
> in a DEC Multia (Pentium variant):

Thanks much for the report, that driver doesn't get much testing.

I believe there is still a problem with cable types other than 10baseT, 
but I would have to search deep in the archives to find info.

	Jeff


