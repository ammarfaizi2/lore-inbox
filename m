Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWJCVxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWJCVxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWJCVxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:53:48 -0400
Received: from smtpout.mac.com ([17.250.248.177]:53440 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030577AbWJCVxq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:53:46 -0400
In-Reply-To: <1df1788c0610031425p4f1ca206teb05590a91eb7659@mail.gmail.com>
References: <1df1788c0610031425p4f1ca206teb05590a91eb7659@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <198AC4CE-A2CC-41DB-8D53-BDFB7959781B@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Registration Weakness in Linux Kernel's Binary formats
Date: Tue, 3 Oct 2006 17:53:30 -0400
To: =?ISO-8859-1?Q?Br=E1ulio_Oliveira?= <brauliobo@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2006, at 17:25:07, Bráulio Oliveira wrote:
> Just forwarding....

Well, you could have checked the list archives first to make sure the  
idiot didn't send it here himself.  Secondly if you're going to  
forward something like this best send it to security@kernel.org first.

Of course, it's partially the abovementioned idiot's fault for BCCing  
a mailing list and several others:
> To: undisclosed-recipients

> Hello,
> The present document aims to demonstrate a design weakness found in  
> the
> handling of simply linked   lists   used   to   register   binary    
> formats   handled   by Linux   kernel,   and   affects   all    
> the   kernel families (2.0/2.2/2.4/2.6), allowing the insertion of  
> infection modules in kernel  space that can be used by malicious  
> users to create infection tools, for example rootkits.

Would be nice if I could get to your paper to actually read it, but  
as it returns a 404 error I'm going to make one brief statement:

If you can load another binary format or access the "simply linked  
lists" of the binfmt chain in any way, then you're root and therefore  
there are easier ways to own the box than patching the kernel.

Cheers,
Kyle Moffett



