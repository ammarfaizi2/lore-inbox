Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUERKVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUERKVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 06:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUERKVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 06:21:37 -0400
Received: from smtp6.idctelecomitalia.biz ([217.169.125.103]:32492 "EHLO
	dtcmfe04.dtc.swing.com") by vger.kernel.org with ESMTP
	id S262902AbUERKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 06:21:32 -0400
From: "Eduard Roccatello" <lilo@roccatello.it>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: R: 2.6.6 issues on IDE and GemTek Radio
Date: Tue, 18 May 2004 11:39:52 +0200
Organization: Novacomp Technology
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAl7tkcaWqPUW2mjQuSvWqZAEAKqodSdQVOEaR9VOf9kh0aQAAAAGXGwAAEAAAAIW6h1QHZvJKk2jz6kCqAzQBAAAAAA==@roccatello.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQ8ukhu7sXM/Z5uSHymyMw4dRjewwAAVLog
In-Reply-To: <1084872281.2781.3.camel@laptop.fenrus.com>
X-OriginalArrivalTime: 18 May 2004 09:48:28.0312 (UTC) FILETIME=[45585980:01C43CBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Anjanv@redhar.com wrote:
>> VP_IDE: User given PCI clock speed impossible (66000), using 33 MHz
instead.
>> VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.
>
>you pass idebus=66 which I suspect is really really wrong....
>
Older kernel haven't had no problem with it. I'll try to remove it but
i think that's not the problem.

Thank you,
Eduard

