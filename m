Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSIQVR5>; Tue, 17 Sep 2002 17:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSIQVR5>; Tue, 17 Sep 2002 17:17:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37831 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264613AbSIQVR4>;
	Tue, 17 Sep 2002 17:17:56 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF2221875F.C481DA7A-ON85256C37.00751BCC@pok.ibm.com>
From: "Duc Vianney" <dvianney@us.ibm.com>
Date: Tue, 17 Sep 2002 16:22:34 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/17/2002 05:22:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>HT enabled with 'noht' ??
>'noht' means "no HT", "no hyperthreading", disabled.

OOPS .. typing too fast .. 'noht' means not-enabled.
HT is the default option on 2.4.19.

Duc.


"Randy.Dunlap" <rddunlap@osdl.org> on 09/17/2002 03:35:53 PM

To:    Duc Vianney/Austin/IBM@IBMUS
cc:    <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject:    Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32



On Tue, 17 Sep 2002, Duc Vianney wrote:

| The following are data comparing the effects of hyperthreading (HT)on
| stock kernel 2.4.19 and 2.5.32.
| Hardware under test. The hardware is a Xeon 1-CPU MP, 1.6 gigahertz,
| and 2.5 GB RAM.
| Kernel under test. When testing under 2.4.19, the kernel was built
| as an SMP kernel, and was run on the hardware with HT enabled through
| the boot option 'noht'.

HT enabled with 'noht' ??
'noht' means "no HT", "no hyperthreading", disabled.

| When testing under 2.5.32, the kernel was
| built as an SMP kernel, and was run on the hardware with HT enabled
| through selecting ACPI in configuration.

--
~Randy





