Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTLERuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTLERuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:50:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:63721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264398AbTLERuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:50:51 -0500
Date: Fri, 5 Dec 2003 09:50:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jason Kingsland <Jason_Kingsland@hotmail.com>
cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <BAY7-DAV52PZku6s33Y00003c18@hotmail.com>
Message-ID: <Pine.LNX.4.58.0312050948030.9125@home.osdl.org>
References: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
 <BAY7-DAV52PZku6s33Y00003c18@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Dec 2003, Jason Kingsland wrote:
>
> Any binary loadable kernel module can be considered a "user program"
> Any interface defined in the kernel header files can be considered a "normal
> system call"

I disagree. No definition of "system call" implies "any random function".
That's a technical term with a technical definition, and that technical
definition is in no way ambiguous when we are talking about a kernel.

		Linus
