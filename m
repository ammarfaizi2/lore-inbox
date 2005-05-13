Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVEMIgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVEMIgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVEMIgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:36:38 -0400
Received: from cad.csie.ncku.edu.tw ([140.116.247.47]:55021 "EHLO
	ismp.csie.ncku.edu.tw") by vger.kernel.org with ESMTP
	id S262308AbVEMIel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:34:41 -0400
Message-Id: <200505130838.j4D8bo8R026303@ismp.csie.ncku.edu.tw>
From: "Wayne Lee" <wnlee@cad.csie.ncku.edu.tw>
To: "'uClinux development list'" <uclinux-dev@uclinux.org>,
       <linux-arm-kernel@lists.arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Cc: "'CE Linux Developers List'" <celinux-dev@tree.celinuxforum.org>
Subject: RE: [uClinux-dev] [Benchmark] Linux 2.6.11.6 ARM MMU mode vs. noMMU mode vs. MVista 2.4.20
Date: Fri, 13 May 2005 16:33:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <0IFW003QR79WYC@mmp1.samsung.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcU1BWcNVc0V74LDSaahcUiPaBabRQAAA+EQAF6QSaAGQZe5wAAAYLmAAgOYOTA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Hyok,

How can we reproduce your experiments on s3c24a0 ports?
Do you release the lmbench for s3c24a0?

Regards,
Wayne

-----Original Message-----
From: uclinux-dev-bounces@uclinux.org
[mailto:uclinux-dev-bounces@uclinux.org] On Behalf Of Hyok S. Choi
Sent: Tuesday, May 03, 2005 10:36 AM
To: uClinux development list; linux-arm-kernel@lists.arm.linux.org.uk;
linux-kernel@vger.kernel.org
Cc: CE Linux Developers List
Subject: [uClinux-dev] [Benchmark] Linux 2.6.11.6 ARM MMU mode vs. noMMU
mode vs. MVista 2.4.20

FYI,

I just put an newer lmbench lat_ctx benchmark result chart,
among linux 2.6.11.6 noMMU mode vs. MMU mode vs. montavista
linux(2.4.20-mvista) at:
http://opensrc.sec.samsung.com/document/ctx-perf-linux-2.6.11.6.pdf

you can find some graphs also at :
http://opensrc.sec.samsung.com/document.html

Hyok



_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org


