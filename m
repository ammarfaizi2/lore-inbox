Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbUAELIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 06:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAELIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 06:08:17 -0500
Received: from [218.94.32.23] ([218.94.32.23]:25103 "EHLO wideinfo.com.cn")
	by vger.kernel.org with ESMTP id S264241AbUAELIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 06:08:13 -0500
From: "Zhenghui Zhou" <zhouzhenghui@cn99.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Any hope for HPT372/HPT374 IDE controller?
Date: Mon, 5 Jan 2004 19:08:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPTEQWyiSRssVJIRjSiTsOiFBo9hQAay+hw
X-Spam-Processed: wideinfo.com.cn, Mon, 05 Jan 2004 19:08:28 +0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 192.168.66.14
X-Return-Path: zhouzhenghui@cn99.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Message-Id: <S264241AbUAELIN/20040105110813Z+22619@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the kernel 2.4.xx integrated driver and software raid, it reported the
same error sometimes. Now it work find on most time, but under heavy works,
it report some errors like FIFO empty, etc.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
tomwallard@soon.com
> Sent: Monday, January 05, 2004 6:12 AM
> To: linux-kernel@vger.kernel.org
> Subject: Any hope for HPT372/HPT374 IDE controller?
> 
> Many people seem to have problems with the Highpoint HPT372 and HPT374 IDE
> controllers. Several months ago there was a thread in which many people
> reported failure and not many people reported success. For example, "hdX:
> lost interrupt" errors right before a crash are a common problem. This was
> happening over a wide range of kernel versions. In my case it happens more
> quickly if there is heavy network or video load at the same time as heavy
> load on this controller. (This is a motherboard with a KT400 chipset).
> 
> Have any recent improvements been made? Does anyone have one of these
> controllers actually working correctly? Does anyone have any idea where to
> begin tracking this problem down?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

