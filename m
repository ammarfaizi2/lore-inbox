Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDOTuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDOTuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWDOTuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:50:03 -0400
Received: from main.gmane.org ([80.91.229.2]:47065 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751325AbWDOTuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:50:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Subject: Re: HP Pavilion dv5320us, amd64 'turion' cpu
Date: Sat, 15 Apr 2006 21:49:49 +0200
Message-ID: <pan.2006.04.15.19.49.48.997414@tbdnetworks.com>
References: <200604151457.12508.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d213-101-247-76.cust.tele2.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006 14:57:12 -0400, Gene Heskett wrote:

> Greetings;
> 
> I've been dl'ing and burning cd's and dvd's at a furious rate for 
> several days now, looking for a 64 bit distribution that will actually 
> boot on this thing, apparently in vain.  i386 stuff works fine.
> The kubuntu 'breezy' 5.10 locks up at the ACPI line regardless of what 
> kernel options you pass trying to disable it.
> 
> The dapper, 6.06, amd64 cd outputs nothing on screen after "Booting the 
> kernel".  I let it sit there for 20 minutes while I caught up on some 
> email.

Try booting with "noapic", that did the trick for me for a HP dv8000z. 
BTW, the latest dapper kernel does not need the noapicc anymore.

</nk>


