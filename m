Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbUCUNNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 08:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUCUNM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 08:12:59 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:44973 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263647AbUCUNM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 08:12:58 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andi Kleen <ak@suse.de>
Subject: Re: Fixes for .cfi directives for x86_64 kgdb
Date: Sun, 21 Mar 2004 18:42:14 +0530
User-Agent: KMail/1.5
Cc: jim.houston@comcast.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net
References: <m33c8788ac.fsf@new.localdomain> <200403191847.43692.amitkale@emsyssoft.com> <20040319202315.3c01a501.ak@suse.de>
In-Reply-To: <20040319202315.3c01a501.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403211842.14885.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 Mar 2004 12:53 am, Andi Kleen wrote:
> On Fri, 19 Mar 2004 18:47:43 +0530
>
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Thanks. Checked into kgdb.sourceforge.net cvs tree
>
> It's not very useful because that tree still has the broken
> "interrupt threads" support.

Does it show interrupt threads or not?
-Amit
