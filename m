Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTFMKtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265349AbTFMKtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:49:53 -0400
Received: from dp.samba.org ([66.70.73.150]:41641 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265339AbTFMKtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:49:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.44765.930081.44739@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jun 2003 21:00:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>, Robert Love <rml@tech9.net>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <1055493713.5169.10.camel@dhcp22.swansea.linux.org.uk>
References: <1055460564.662.339.camel@localhost>
	<Pine.LNX.4.44.0306121629590.11379-100000@cherise>
	<16105.3943.510055.309447@nanango.paulus.ozlabs.org>
	<1055493713.5169.10.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> lock xaddl $1, [foo]

On 386?  I stand corrected. :)

Paul.
