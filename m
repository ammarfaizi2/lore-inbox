Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUGTD1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUGTD1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 23:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUGTD1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 23:27:21 -0400
Received: from mail2.haninternet.net ([211.63.64.79]:26638 "EHLO
	mail2.haninternet.net") by vger.kernel.org with ESMTP
	id S265041AbUGTD1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 23:27:20 -0400
From: =?ks_c_5601-1987?B?udogwaS/+A==?= <jwpark@haninternet.co.kr>
To: <linux-kernel@vger.kernel.org>
Subject: equalize_2.4.18.patch - patch problem on multi-processor
Date: Tue, 20 Jul 2004 12:27:18 +0900
Message-ID: <373769E1AB84A74CBBFA6ED3912F0557B6D68D@han-ex.haninternetworks.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about equalize_2.4.18.patch.
I use a kernel 2.4.25.
And I have multi-processor(Xeon dual) machine.
I had patch equalize_2.4.18.patch file.
And I had check ¡®Symmetric multi-processing support¡¯ kernel compile
option. When I use that kernel, the system is down. But, I had not check
¡®Symmetric multi-processing support¡¯ kernel compile option, and, I had
complie that kernel. 
When I uset that kernel, the system is good.
How to solve that problem?

