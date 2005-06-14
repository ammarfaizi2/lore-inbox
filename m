Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFNHhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFNHhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFNHhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:37:38 -0400
Received: from general.keba.co.at ([193.154.24.243]:37970 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261301AbVFNHhc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:37:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Date: Tue, 14 Jun 2005 09:37:42 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732323C@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
Thread-Index: AcVws1K4HtEYqxq5RuaOJ2/knSzMggAAC6RQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "kus Kusche Klaus" <kus@keba.com>
Cc: "Serge Noiraud" <serge.noiraud@bull.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * kus Kusche Klaus <kus@keba.com> wrote:
> > I was one of those who tried to get kgdb working.
> > 
> > Here I described how far I came:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0505.1/0700.html
> 
> does ethernet debugging work if you disable the netpoll 
> WARN_ON() that 
> triggers?

Sorry, I can't try at the moment:
That installation doesn't exist any longer,
and debuggers aren't on the current agenda of our RT linux analysis.

I'll try if I've some spare time, but no promises.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
