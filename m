Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293393AbSCARGT>; Fri, 1 Mar 2002 12:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293394AbSCARGO>; Fri, 1 Mar 2002 12:06:14 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:11435 "EHLO
	e23.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S293393AbSCARGG>; Fri, 1 Mar 2002 12:06:06 -0500
Date: Fri, 01 Mar 2002 11:05:43 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: thread groups bug? 
Message-ID: <56680000.1015002343@baldur>
In-Reply-To: <22890.1015000691@warthog.cambridge.redhat.com>
In-Reply-To: <22890.1015000691@warthog.cambridge.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Friday, March 01, 2002 16:38:11 +0000 David Howells
<dhowells@redhat.com> wrote:

> I've attached a patch to kill all subsidiary threads in a thread group
> when the main thread exits. I've made it against 2.5.6-pre1 since -pre2
> fails to compile in the IDE code somewhere.

You beat me to it.  Nice work.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

