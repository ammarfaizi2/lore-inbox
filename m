Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264668AbSJOSJF>; Tue, 15 Oct 2002 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSJOSJF>; Tue, 15 Oct 2002 14:09:05 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:59331 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264668AbSJOSJF>; Tue, 15 Oct 2002 14:09:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with jfs and dbench 80 (ext3, reiserfs, xfs are OK)
Date: Tue, 15 Oct 2002 13:17:00 -0500
X-Mailer: KMail [version 1.4]
References: <1034695794.13083.27.camel@spc9.esa.lanl.gov>
In-Reply-To: <1034695794.13083.27.camel@spc9.esa.lanl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210151317.01493.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 10:29, Steven Cole wrote:
> I have run into problems running dbench with 80 clients
> on a jfs partition.

Steven,
I haven't run dbench with that many clients myself (or if I had, it's 
been a while).  I'm currently working on fixing some scalability issues 
in JFS.  In doing so, I'll try to reproduce your problem and make sure 
it gets fixed.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

