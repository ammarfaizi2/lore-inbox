Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSHMMnL>; Tue, 13 Aug 2002 08:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSHMMnL>; Tue, 13 Aug 2002 08:43:11 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:58382 "EHLO
	bigk.eargle.com") by vger.kernel.org with ESMTP id <S315275AbSHMMnL>;
	Tue, 13 Aug 2002 08:43:11 -0400
Message-ID: <004401c242c7$842222f0$0b2b0a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Jeff Chua" <jeffchua@silk.corp.fedex.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208131503350.1075-100000@boston.corp.fedex.com>
Subject: Re: searching for dell 2650 PERC3-DI driver
Date: Tue, 13 Aug 2002 08:46:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm buying a Dell PowerEdge 2650 and need to know where to get driver for
> the RAID controller
>
>         PERC3-DI, PERC3-DC, or PERC3-QC
>
> Does anyone know what kind of network adaptor is on the board?

The best place that I know of for information about ANY Dell server and
Linux is at http://www.domsch.com/linux/.  There are instructions there on
how to get recent versions of the aacraid driver to recognize this card
during boot, assuming a fairly recent distribution.

The onboard network adapter is Broadcom NeXtreme Gigabit adapter.  I believe
this is supported in recent distributions/kernels by the tg3 driver and Dell
provides binary drivers from Broadcom as well.

Later,
Tom

