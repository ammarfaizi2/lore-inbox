Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUBIItI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBIItI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:49:08 -0500
Received: from [152.101.81.89] ([152.101.81.89]:6405 "HELO southa.com")
	by vger.kernel.org with SMTP id S264137AbUBIItG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:49:06 -0500
Message-ID: <015801c3eeea$aabd5a80$9c02a8c0@southa.com>
From: "Kyle Wong" <kylewong@southa.com>
To: "Bas Mevissen" <ml@basmevissen.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl>
Subject: Re: ICH5 with 2.6.1 very slow
Date: Mon, 9 Feb 2004 16:56:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No hardware raid, it's kernel built-in md driver.

----- Original Message ----- 
From: "Bas Mevissen" <ml@basmevissen.nl>
To: "Kyle" <kyle@southa.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, February 09, 2004 4:32 PM
Subject: Re: ICH5 with 2.6.1 very slow


> Kyle wrote:
> 
> > Today I tried 
> 
> (...)
> 
> This is quite strange. The only thing I can think of is that the 
> hardware (?) raid1 is causing problems with 2.6.
> 
> Is there a possibility for you to test without it?
> 
> Currently, I don't have a decent PATA disk luyng around, so I cannot 
> verify anything for you.
> 
> Regards,
> 
> Bas.
> 
> 
> 
