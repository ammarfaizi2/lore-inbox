Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUKRVU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUKRVU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKRVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:18:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36274 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261178AbUKRVRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:17:17 -0500
Date: Thu, 18 Nov 2004 22:17:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Tomas Carnecky <tom@dbservice.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
In-Reply-To: <419D10DF.4040902@nortelnetworks.com>
Message-ID: <Pine.LNX.4.53.0411182216160.16465@yvahk01.tjqt.qr>
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com>
 <Pine.LNX.4.53.0411182146060.29376@yvahk01.tjqt.qr> <419D10DF.4040902@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So they could make themselves a favor and run something like seti@home.
>
>That does consume more energy than just sitting at idle.  I've seen some
>estimates of how much it costs to run seti 24/7 rather than just sit idle, and
>the price was something like $80/year.

For CPUs which don't have some sort of speedstep, it does not matter.
(Please correct me if I am wrong. It might be that HLT cycles are still more
power-conservative even without speedstep than 24/7 on the FPU.)


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
