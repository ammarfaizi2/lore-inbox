Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTDXUnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTDXUnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:43:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264442AbTDXUnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:43:40 -0400
Subject: Re: [dcl_discussion] [ANNOUNCE] OSDL Whitepaper: "Reducing System
	Reboot Time With Kexec"
From: Andy Pfiffer <andyp@osdl.org>
To: "Timothy D. Witham" <wookie@osdl.org>
Cc: fastboot@osdl.org, cgl_discussion@osdl.org, dcl_discussion@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1051208689.1787.326.camel@localhost.localdomain>
References: <1051204164.4840.17.camel@andyp.pdx.osdl.net>
	 <1051208689.1787.326.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1051217727.2302.10.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 13:55:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 11:24, Timothy D. Witham wrote:
>   So questions and comments are being accepted?

Sure.

>      The actual values from the measurements in an appendix 
>      would be helpful.  Including the boot time breakdown
>      for the 8 way.
...
     On your chart, the time saved column is distracting to
>      me as it is extra data.
...
     On the relative percentage column
>      if it could be kexec/full boot that would make it so that
>      I wouldn't have to go back to the text to understand the
>      column.

Fair enough.  The 8-way measurements aren't currently available because
that specific system has been assigned to another OSDL Lab Associate.

>      Also on the kernel boot time, I think that you 
>      are talking about the kernel init time.  So why not call
>      it that?

I was hoping to avoid dancing around the semantics and interpretation of
"booted" vs. "initialized".  I guess that didn't work as well as I had
hoped. ;^)

> 
>   On future and ongoing work.
>      The crash dump seems to be orthogonal to fast booting.  I 
>      would like to see future and ongoing work that applies to
>      fast booting. 
> 
> Tim

Thanks for taking the time to generate feedback.

Andy



