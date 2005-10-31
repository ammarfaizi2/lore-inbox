Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVJaMdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVJaMdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJaMdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:33:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58261 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932408AbVJaMdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:33:06 -0500
Subject: Re: 4GB memory and Intel Dual-Core system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4365920D.2080009@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
	 <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade>
	 <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade>
	 <20051027221756.M55421@linuxwireless.org>
	 <1130711165.32734.11.camel@localhost.localdomain>
	 <4365920D.2080009@linuxwireless.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Oct 2005 13:02:39 +0000
Message-Id: <1130763759.9145.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-10-30 at 20:39 -0700, Alejandro Bonilla Beeche wrote:
> I guess you are right and wrong. The architecture has the limitation, 
> the chipset as well and the OS. According to this document, it is the 
> fault of the architecture as well as it requires to support addressing 
> which is not available *stock*, only several other providers have added 
> such "mapping" to get a better use of the memory.

That document reads like a "don't blame us because we didn't bother to
do remapping". That is an Intel business decision not a hardware limit,
as is shown by other vendors whose hardware can do the remap.


