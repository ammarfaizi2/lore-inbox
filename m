Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280538AbRKJG3Y>; Sat, 10 Nov 2001 01:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280508AbRKJG3O>; Sat, 10 Nov 2001 01:29:14 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:10505 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280554AbRKJG27>;
	Sat, 10 Nov 2001 01:28:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Ranch <dranch@juniper.net>
Cc: linux-kernel@vger.kernel.org, dranch@trinnet.net
Subject: Re: 2.2.20 - Possible module symbol bug 
In-Reply-To: Your message of "Fri, 09 Nov 2001 12:48:34 -0800."
             <3BEC4122.4C4DFB32@juniper.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Nov 2001 17:28:45 +1100
Message-ID: <14358.1005373725@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2001 12:48:34 -0800, 
David Ranch <dranch@juniper.net> wrote:
>I think I've found a bug in 2.2.20.  Specifically, 
>if I compile up a 2.2.20 kernel on a Mandrake 7.0 box
>(glibc 2.1.3 - modutil 2.1.121) and run "depmod -a", all 
>IPMASQ modules, loop, and ide-scsi modules fail dependencies.

Broken kernel Makefiles, http://www.tux.org/lkml/#s8-8

