Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290916AbSASGlq>; Sat, 19 Jan 2002 01:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290917AbSASGl3>; Sat, 19 Jan 2002 01:41:29 -0500
Received: from sm14.texas.rr.com ([24.93.35.41]:2780 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S290916AbSASGlY>;
	Sat, 19 Jan 2002 01:41:24 -0500
Message-Id: <200201190643.g0J6hKpL021108@sm14.texas.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: "Raman S" <raman_s_@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Question] Viewing and changing memory contents in Linux
Date: Sat, 19 Jan 2002 00:46:30 -0600
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <F241diixjnzi95HfqR70000b945@hotmail.com>
In-Reply-To: <F241diixjnzi95HfqR70000b945@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gdb lets you do it - but only for virtual addresses in the context of a 
specific process. If you're talking about memory referenced by physical 
address then I guess you'd have to be in kernel mode.

-Marvin


On Friday 18 January 2002 10:43 pm, Raman S wrote:
> Hi,
>   Is there an open source utility that allows viewing and modifying
> memory contents dynamically while the system is running.....
>    Thanks.
> Raman S
>

