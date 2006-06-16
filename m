Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWFPRCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWFPRCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWFPRCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 13:02:49 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:53508 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751495AbWFPRCs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 13:02:48 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: tg3 timeouts with 2.6.17-rc6
Date: Fri, 16 Jun 2006 10:02:32 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
Thread-Topic: tg3 timeouts with 2.6.17-rc6
Thread-Index: AcaRZQAOJ8IKlXscQVWUDRbMoqZY+wAAN8RA
From: "Michael Chan" <mchan@broadcom.com>
To: "Juergen Kreileder" <jk@blackdown.de>, linux-kernel@vger.kernel.org
cc: netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006061606; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230352E34343932453241342E303030332D412D;
 ENG=IBF; TS=20060616170239; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006061606_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 688C3BA60HW32563474-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Kreileder

> I'm seeing frequent network timeouts on my PowerMac G5 Quad with
> 2.6.17-rc6.  The timeouts are easily reproducible with moderate
> network traffic, e.g. by using bittorrent.
> 

Did this use to work with an older kernel or older tg3 driver? If
yes, what version?

Please also provide the full tg3 probing output during modprobe and
ifconfig up. Thanks.

