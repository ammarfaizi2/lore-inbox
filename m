Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTDOWdB (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTDOWdB 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:33:01 -0400
Received: from [12.47.58.203] ([12.47.58.203]:16805 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264136AbTDOWdA (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 18:33:00 -0400
Date: Tue, 15 Apr 2003 15:43:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: florin@iucha.net (Florin Iucha)
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server
 terminates
Message-Id: <20030415154355.08ef6672.akpm@digeo.com>
In-Reply-To: <20030415182057.GC29143@iucha.net>
References: <20030415133608.A1447@cuculus.switch.gts.cz>
	<20030415125507.GA29143@iucha.net>
	<3E9C03DD.3040200@oracle.com>
	<20030415164435.GA6389@rivenstone.net>
	<20030415182057.GC29143@iucha.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 22:44:45.0659 (UTC) FILETIME=[9CC93AB0:01C303A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

florin@iucha.net (Florin Iucha) wrote:
>
> I think it has to do with the interaction between XFree86 4.3.0 and
> the AGP code.

Has anyone tried disabling kernel AGP support and retesting?

