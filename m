Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVJ3V4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVJ3V4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVJ3V4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:56:34 -0500
Received: from [81.2.110.250] ([81.2.110.250]:24499 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751169AbVJ3V4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:56:33 -0500
Subject: Re: 4GB memory and Intel Dual-Core system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051027221756.M55421@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
	 <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade>
	 <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade>
	 <20051027221756.M55421@linuxwireless.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Oct 2005 22:26:05 +0000
Message-Id: <1130711165.32734.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-27 at 18:20 -0400, Alejandro Bonilla wrote:
> Dude, again. This has nothing to do with the CPU. The arch IA32 is simply
> _not_ made for 4GB, so, some motherboards manufacturers make a workaround like

Wrong IA-32 supports more than 4Gb in PAE 36bit physical 32bit virtual
mode and has done since the Preventium Pro

