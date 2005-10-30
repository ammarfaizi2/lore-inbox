Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVJ3Vyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVJ3Vyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJ3Vyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:54:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:22963 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751166AbVJ3Vyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:54:36 -0500
Subject: Re: 4GB memory and Intel Dual-Core system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051027211203.M33358@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Oct 2005 22:24:14 +0000
Message-Id: <1130711054.32734.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-27 at 17:15 -0400, Alejandro Bonilla wrote:
> > so there is no way to give me back the "lost" memory. Is it possible
> > that another motherboard might help?
> 
> AFAIK, No. AMD and Intel will always do the same thing until we all move to
> real IA64.

Fortunately you can use a real processor with 4GB of RAM as well as an
IA-64 (if you can find one even!). It is chipset dependant whether RAM
lost to the PCI window can be made to appear over the 4GB boundary with
a PAE capable intel ia32 processor (or clone) with an AMD x86-64
processor (or clone)

It depends entirely on the chipset quality

