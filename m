Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbSJ1IW3>; Mon, 28 Oct 2002 03:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbSJ1IW2>; Mon, 28 Oct 2002 03:22:28 -0500
Received: from smtpde02.sap-ag.de ([155.56.68.170]:39397 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262198AbSJ1IW2>; Mon, 28 Oct 2002 03:22:28 -0500
From: Christoph Rohland <cr@sap.com>
To: chrisl@vmware.com
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, chrisl@gnuchina.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com>
	<20021024175718.GA1398@vmware.com>
	<20021024183327.GS3354@dualathlon.random>
	<20021024191531.GD1398@vmware.com>
Organisation: Development SAP J2EE Engine
Date: Mon, 28 Oct 2002 09:28:22 +0100
In-Reply-To: <20021024191531.GD1398@vmware.com> (chrisl@vmware.com's message
 of "Thu, 24 Oct 2002 12:15:32 -0700")
Message-ID: <elabj7bt.fsf@sap.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Common Lisp
 (Windows [3]), i586-pc-win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, chrisl@vmware.com wrote:
> Yes, shmfs seems to be the only choice so far.

So why don't you use Posix or SYSV shared mem?

Greetings
		Christoph


