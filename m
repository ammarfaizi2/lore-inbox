Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271303AbTGQBSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271312AbTGQBSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:18:11 -0400
Received: from [219.150.172.3] ([219.150.172.3]:16186 "EHLO mail.ndsc.com.cn")
	by vger.kernel.org with ESMTP id S271303AbTGQBSJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:18:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: pmc network card problem
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Thu, 17 Jul 2003 09:35:28 +0800
content-class: urn:content-classes:message
Message-ID: <7A7A7A38134E244784EDAC428C538AE92A5746@mail.ndsc.com.cn>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pmc network card problem
Thread-Index: AcNMA/EavWvAaK+USECGr3ILLRGx9A==
From: =?gb2312?B?09rmug==?= <yujing@ndsc.com.cn>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
 I'm porting linux on my motorola lopec mpc7410 board with a zynx zx212 dual-port ethernet card on it.The problem is that the kernel can't start up with the ethernet card on,while without it everything is perfect.Since zx212 is compatible with 21143,I build the kernel with the "tulip" option on.It should be no problem,but it happened. It halts after "now booting the kernel". Can you help me ?



Best Regard
Yu 

