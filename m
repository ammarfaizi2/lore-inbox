Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSEXPUV>; Fri, 24 May 2002 11:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317183AbSEXPUU>; Fri, 24 May 2002 11:20:20 -0400
Received: from daimi.au.dk ([130.225.16.1]:23138 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317182AbSEXPUR>;
	Fri, 24 May 2002 11:20:17 -0400
Message-ID: <3CEE5A2D.77EA2E66@daimi.au.dk>
Date: Fri, 24 May 2002 17:20:13 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: It hurts when I shoot myself in the foot
In-Reply-To: <E17BGzF-0006b3-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> I have code to detect the multiplier of each CPU but never got around to
> making the kernel detect this and turn off TSC usage so you need to boot
> with "notsc" in such a case

If the kernel knew multipliers couldn't it actually use the TSCs
anyway? Of course it would take some work, but is there any
reason why it would not be posible?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
