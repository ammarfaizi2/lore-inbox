Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUDVDIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUDVDIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbUDVDIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:08:10 -0400
Received: from fmr11.intel.com ([192.55.52.31]:41619 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S261724AbUDVDIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:08:06 -0400
Subject: Re: Two problems after upgrade tto 2.4.26
From: Len Brown <len.brown@intel.com>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F936B@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F936B@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082603280.16336.152.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 23:08:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-20 at 07:09, Martin Knoblauch wrote:
> >Hi,
> >
> >
> >after upgrading 2.4.23->2.4.26 I am seeing/heariing two problems on
> >my "HP Omnibookk 6100"":
> >
> >a) I am getting a lot of double hits when typing (juust see this
> mmail.
> >I am not correecting the errors on purpose :-) While I have some
> >sttupid mistyping habits, double hits all over thhe place did not
> >belong to them up to now.
> >
> 
>  Short update. Problem a) seems to be acpi-related. When booting with
> "acpi=off", the keyboard behaves OK. 
> 
>  Not only the keyboard is affected, but also the mouse. I just did not
> see it immediatelly, but with acpi enabled I am loosing pointer
> events.
> 
> >b)) Before the upgrade the notebook fan was rarely running at full
> >speed. AAnd if, only forr short ttimes. Now it kicks in frequeently
> and
> >for up to 15 minutes.
> >

Does /proc/interrupts show any acpi events?
Did it in 2.4.23?


