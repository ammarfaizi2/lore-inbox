Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWJLWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJLWbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWJLWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:31:48 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:22965 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1751198AbWJLWbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:31:47 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-16.tower-29.messagelabs.com!1160692306!26603189!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] epca: privent from panic on tty_register_driver()failure
Date: Thu, 12 Oct 2006 17:31:45 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F803F7E@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] epca: privent from panic on tty_register_driver()failure
Thread-Index: Acbt68l+HTZyYJW4TMiEF73Qh1I79wAYlQkg
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       "Eng.Linux" <Eng.Linux@digi.com>
X-OriginalArrivalTime: 12 Oct 2006 22:31:46.0534 (UTC) FILETIME=[337D3060:01C6EE4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ar Llu, 2006-10-09 am 18:06 +0900, ysgrifennodd Akinobu Mita:
> > This patch makes epca fail on initialization failure 
> instead of panic.
> > 
> > Cc: "Digi International, Inc" <Eng.Linux@digi.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 
> 

Acked-by: Scott Kilau <scottk@digi.com>
