Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUAIVTh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAIVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:19:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:20687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264163AbUAIVTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:19:36 -0500
Date: Fri, 9 Jan 2004 13:20:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.1-mm1
Message-Id: <20040109132038.2dfaef02.akpm@osdl.org>
In-Reply-To: <3FFED73D.8020502@gmx.de>
References: <20040109014003.3d925e54.akpm@osdl.org>
	<3FFED73D.8020502@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:
>
> Hi,
> 
> could it be that you took out /or forgot to insterst the work-around for 
> nforce2+apic? At least I did a test with cpu disconnect on and booted 
> kernel and it hang. (I also couldn't find the work-around in the 
> sources.) I remember an earlier mm kernel had that workaround inside.
> 

I discussed it with Bart and he felt that it was not a good way of fixing
the problem.  I'm not sure if he has a better fix in the works though..
