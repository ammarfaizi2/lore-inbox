Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288729AbSADTfb>; Fri, 4 Jan 2002 14:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSADTfO>; Fri, 4 Jan 2002 14:35:14 -0500
Received: from codepoet.org ([166.70.14.212]:43784 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S288729AbSADTfH>;
	Fri, 4 Jan 2002 14:35:07 -0500
Date: Fri, 4 Jan 2002 12:35:06 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104193506.GA15540@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103190219.B27938@thyrsus.com> <Pine.GSO.4.21.0201031944320.23693-100000@weyl.math.psu.edu> <20020103195207.A31252@thyrsus.com> <20020104081802.GC5587@codepoet.org> <20020104071940.A10172@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020104071940.A10172@thyrsus.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jan 04, 2002 at 07:19:40AM -0500, Eric S. Raymond wrote:
> Erik Andersen <andersen@codepoet.org>:
> > I once wrote up /dev/ps and /dev/mounts drivers to eliminate proc
> > for embedded systems (pointer available if you care).  It was not
> > warmly received, but I did form some opinions in the process.
> 
> Sure, I'd like to see this work.

http://busybox.net/cgi-bin/cvsweb/busybox/examples/kernel-patches/

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
