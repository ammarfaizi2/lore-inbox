Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263161AbTC1Vba>; Fri, 28 Mar 2003 16:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTC1Vba>; Fri, 28 Mar 2003 16:31:30 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:28033 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S263161AbTC1Vb3>;
	Fri, 28 Mar 2003 16:31:29 -0500
Subject: Re: [2.5.66] Enormous interrupt load with ACPI
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1048878306.714.11.camel@devil>
References: <1048878306.714.11.camel@devil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048887829.701.28.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Mar 2003 23:43:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realized that I have not received any linux-kernel mail since Tuesday.
The list server must have dropped me for some reason. I'm resubscribed
now but I may have missed a response or two.

	MikaL

On Fri, 2003-03-28 at 21:05, Mika Liljeberg wrote:
> Hi All,
> 
> If I enable ACPI on my machine I seem to get more than 80 000 interrupts
> per second on IRQ9, sucking up roughly 30% of CPU time. Boot log
> appended.
> 
> 	MikaL

