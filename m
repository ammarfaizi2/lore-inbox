Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284053AbRLAKyd>; Sat, 1 Dec 2001 05:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284065AbRLAKyX>; Sat, 1 Dec 2001 05:54:23 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:59149 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284053AbRLAKyN>;
	Sat, 1 Dec 2001 05:54:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15368.46723.286664.552743@argo.ozlabs.ibm.com>
Date: Sat, 1 Dec 2001 21:52:51 +1100 (EST)
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in make bzImage (ppc)
In-Reply-To: <3C061FD7.9646F772@pcsystems.de>
In-Reply-To: <3C061FD7.9646F772@pcsystems.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius writes:

> I tried to compile the 2.4.13 kernel on a ppc.
> It failed. The output indicates it is possible bad asm or a compiler
> error. What is it ?

You need a newer gcc, I recommend 2.95.3 or 2.95.4.

Paul.
