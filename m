Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVJaXDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVJaXDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVJaXDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:03:13 -0500
Received: from dvhart.com ([64.146.134.43]:28073 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932552AbVJaXDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:03:11 -0500
Date: Mon, 31 Oct 2005 15:03:08 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <12100000.1130799788@flay>
In-Reply-To: <1130711165.32734.11.camel@localhost.localdomain>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade> <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade> <20051027221756.M55421@linuxwireless.org> <1130711165.32734.11.camel@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, October 30, 2005 22:26:05 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2005-10-27 at 18:20 -0400, Alejandro Bonilla wrote:
>> Dude, again. This has nothing to do with the CPU. The arch IA32 is simply
>> _not_ made for 4GB, so, some motherboards manufacturers make a workaround like
> 
> Wrong IA-32 supports more than 4Gb in PAE 36bit physical 32bit virtual
> mode and has done since the Preventium Pro

Indeed ... I have 64GB ia32 boxes ;-)

M.

