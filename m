Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVAOFeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVAOFeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 00:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVAOFeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 00:34:21 -0500
Received: from [203.152.41.3] ([203.152.41.3]:20460 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S262215AbVAOFeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 00:34:08 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.61.0501140751520.4941@montezuma.fsmlabs.com>
References: <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
	 <41BB32A4.2090301@pobox.com> <1102824735.17081.187.camel@cpu0>
	 <Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com>
	 <1102828235.17081.189.camel@cpu0>
	 <Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
	 <1102842902.10322.200.camel@cpu0>
	 <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	 <1103027130.3650.73.camel@cpu0>  <20041216074905.GA2417@c9x.org>
	 <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	 <1103646195.3652.196.camel@cpu0>
	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
	 <1105637178.5491.167.camel@cpu10>
	 <Pine.LNX.4.61.0501140751520.4941@montezuma.fsmlabs.com>
Content-Type: multipart/mixed; boundary="=-ic2IcJfJOrWE6VvDB39S"
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Date: Sat, 15 Jan 2005 12:34:01 +0700
Message-Id: <1105767241.5078.1.camel@cpu10>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ic2IcJfJOrWE6VvDB39S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-01-14 at 16:34 -0700, Zwane Mwaikambo wrote:
> On Fri, 14 Jan 2005, Rudolf Usselmann wrote:
> 
> > > Ok don't worry about trying to isolate it, there should be a fix for it by 
> > > 2.6.10.
> > 
> > just wondering if there where any fixes submitted with 2.6.10
> > final release for the memory problem. I did not see anything
> > from bugzilla ....
> 
> Hi Rudolf,
> 	I've replied on bugzilla.
> 
> Thanks,
> 	Zwane


Hi Zwane,

I tried the new kernel, same results. Still can't use the
extra memory.

Attached is the "dmesg" output ...

Kind Regards,
rudi


--=-ic2IcJfJOrWE6VvDB39S
Content-Disposition: attachment; filename=new_dump.gz
Content-Type: application/x-gzip; name=new_dump.gz
Content-Transfer-Encoding: base64

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


--=-ic2IcJfJOrWE6VvDB39S--

