Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRKMPsd>; Tue, 13 Nov 2001 10:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRKMPsX>; Tue, 13 Nov 2001 10:48:23 -0500
Received: from mail205.mail.bellsouth.net ([205.152.58.145]:50451 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S273305AbRKMPsK>; Tue, 13 Nov 2001 10:48:10 -0500
Message-ID: <000301c16b98$b1a276a0$5201a8c0@genesis>
From: "Ben Israel" <ben@genesis-one.com>
To: <linux-kernel@vger.kernel.org>
Cc: "John O'Neil" <joneil@genesis-one.com>
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
Subject: Re: File System Performance
Date: Mon, 12 Nov 2001 11:40:09 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> It works, and it'll get you close to disk bandwidth with this test.
> But the effects of this change on other workloads (the so-called
> "slow growth" scenario) still needs to be understood and tested.
>

Does compiling the kernel constitute a reasonable example of a slow
growth workload? If not what is a slow growth workload where file
system performance is important?






