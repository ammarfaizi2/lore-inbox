Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWBUXbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWBUXbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBUXbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:31:09 -0500
Received: from nevyn.them.org ([66.93.172.17]:25022 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751215AbWBUXbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:31:07 -0500
Date: Tue, 21 Feb 2006 18:30:01 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Michael Kerrisk <mtk-manpages@gmx.net>,
       Roland McGrath <roland@redhat.com>
Subject: Re: PTRACE_SETOPTIONS documentantion?
Message-ID: <20060221233001.GB3778@nevyn.them.org>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Michael Kerrisk <mtk-manpages@gmx.net>,
	Roland McGrath <roland@redhat.com>
References: <20060217075358.GB9230@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217075358.GB9230@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 08:53:58AM +0100, Heiko Carstens wrote:
> Hi all,
> 
> I'm just wondering if there is any sort of documentation for the ptrace
> request PTRACE_SETOPTIONS and its PTRACE_O_* flags available?
> Or is this just some sort of "if you want to use this interface, read
> the kernel sources" ? :)
> The same question could be asked for PTRACE_GETEVENTMSG, PTRACE_GETSIGINFO
> and PTRACE_SETSIGINFO.

Basically there's none; you're welcome to write some, and to consult
the GDB sources for example usage.  Maybe the documentation would be
appropriate for the man pages.

-- 
Daniel Jacobowitz
CodeSourcery
