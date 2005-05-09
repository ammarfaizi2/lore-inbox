Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVEIJKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVEIJKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVEIJKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:10:42 -0400
Received: from general.keba.co.at ([193.154.24.243]:21968 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261160AbVEIJKh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:10:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Date: Mon, 9 May 2005 11:10:22 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323202@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
Thread-Index: AcVUakIVLVVnHXAJRAuCxRGJaB0MzQADFYlw
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Cc: <inaky.perez-gonzalez@intel.com>, <dwalker@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have released the -V0.7.47-00 Real-Time Preemption patch, 
> which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this patch reintroduces the plist.h code from Daniel Walker and Inaky 
> Perez-Gonzalez. It's also a merge to 2.6.12-rc4.
> 
> to build a -V0.7.47-00 tree, the following patches have to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>    
> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
>    
>
http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0
.7.47-00

It lacks "plist.h", but two "#include" refer to it?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
