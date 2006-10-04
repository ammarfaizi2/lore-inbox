Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWJDDth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWJDDth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 23:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWJDDth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 23:49:37 -0400
Received: from relay01.pair.com ([209.68.5.15]:25867 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751093AbWJDDtg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 23:49:36 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: goodfellas@shellcode.com.ar
Subject: Re: =?utf-8?q?Registration=C2=A0Weakness=C2=A0in=C2=A0Linux=C2=A0Kernel=27?=
 =?utf-8?q?s=C2=A0Binary=C2=A0formats?=
Date: Tue, 3 Oct 2006 22:49:10 -0500
User-Agent: KMail/1.9.4
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, endrazine <endrazine@gmail.com>,
       Stephen Hemminger <shemminger@osdl.org>, Valdis.Kletnieks@vt.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1159902785.2855.34.camel@goku.staff.locallan>
In-Reply-To: <1159902785.2855.34.camel@goku.staff.locallan>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610032249.33712.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 14:12, SHELLCODE Security Research wrote:
> Hello,
> The present document aims to demonstrate a design weakness found in the
> handling of simply
> linked   lists   used   to   register   binary   formats   handled   by
> Linux   kernel,   and   affects   all   the   kernel families
> (2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
> kernel­ space that can be used by malicious users to create infection
> tools, for example rootkits.

Yay, you've been Slashdotted!

Question: Why did you personally submit this to Slashdot when it is absolutely 
clear that the observation is akin to figuring out a process can call fork() 
and exec() and become "/bin/rm" with an argv of "/bin/rm", "-rf", and "*"?

Is this what you call good marketing?

> POC, details and proposed solution at:
> English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
> Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf
>

Thanks,
Chase
