Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbTCSAVk>; Tue, 18 Mar 2003 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCSAVk>; Tue, 18 Mar 2003 19:21:40 -0500
Received: from packet.digeo.com ([12.110.80.53]:61353 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262881AbTCSAVj>;
	Tue, 18 Mar 2003 19:21:39 -0500
Date: Tue, 18 Mar 2003 16:26:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
Message-Id: <20030318162601.78f11739.akpm@digeo.com>
In-Reply-To: <873clkw6ui.fsf@lapper.ihatent.com>
References: <20030318031104.13fb34cc.akpm@digeo.com>
	<87adfs4sqk.fsf@lapper.ihatent.com>
	<87bs08vfkg.fsf@lapper.ihatent.com>
	<20030318160902.C21945@flint.arm.linux.org.uk>
	<873clkw6ui.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 00:31:59.0058 (UTC) FILETIME=[F3D30320:01C2EDAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> I'm not suspecting the PCI in particular for the PCIC-bits, only
> making X and the Radeon work again. But here you are:

Something bad has happened to the Radeon driver in recent kernels.  I've seen
various reports with various syptoms and some suspicion has been directed at
the AGP changes.

But as far as I know nobody has actually got down and done the binary search
to find out exactly when it started happening.

