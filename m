Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293075AbSCOSka>; Fri, 15 Mar 2002 13:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293091AbSCOSkV>; Fri, 15 Mar 2002 13:40:21 -0500
Received: from pD953C2CA.dip.t-dialin.net ([217.83.194.202]:44556 "EHLO
	athene.meding-zuehl.net") by vger.kernel.org with ESMTP
	id <S293075AbSCOSkM>; Fri, 15 Mar 2002 13:40:12 -0500
Message-Id: <200203151839.g2FIdY927470@athene.meding-zuehl.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hauke Joachim Zuehl <hzuehl@athene.dnsalias.org>
To: jmarin@isp.qnet.com.pe
Subject: Re: request_module[block-major-8]: Root fs not mounted
Date: Fri, 15 Mar 2002 19:39:07 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3C91B2DC.AAB49E5F@isp.qnet.com.pe>
In-Reply-To: <3C91B2DC.AAB49E5F@isp.qnet.com.pe>
Cc: LKM <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. März 2002 09:37 schrieb Jose Luis Marin Perez:

> Kernel panic:VFS:Unbale to mount root fs on 08:03
>
> In which I have failed?

It seems you have compiled the driver for your root fs as a module and not 
into the kernel.

>
> Thanks

HTH

>
> Jose Luis

Regards,
Hauke
