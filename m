Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTJaAZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJaAZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:25:32 -0500
Received: from sea2-dav13.sea2.hotmail.com ([207.68.164.117]:20747 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262538AbTJaAZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:25:31 -0500
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question on mips-linux xross compilation
Date: Thu, 30 Oct 2003 16:20:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV13uJDX5gnlz0000cecd@hotmail.com>
X-OriginalArrivalTime: 31 Oct 2003 00:25:30.0629 (UTC) FILETIME=[7DA8F350:01C39F45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
> I am having mips-linux cross compiler toolchains installed on my machine.
I
> m trying to compile my code which includes the system header
<asm/system.h>.
> But the G++ compiler is cribbing for a particular line in this header
file.
> (line no 256).
> The erro is "parse error before string constant".
> Basically it is not liking 2 extern  declaratives in front of the function
> void * resume().
> Pls note one extern comes from asmlinkage definition which is defined as
> extern "C".
>
> Pls help me out in this if u have any idea..
>
> thanks in advance.
>
> Sankarshana M
