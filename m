Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTBYDYj>; Mon, 24 Feb 2003 22:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBYDYj>; Mon, 24 Feb 2003 22:24:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:6134 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265414AbTBYDYj>;
	Mon, 24 Feb 2003 22:24:39 -0500
Date: Mon, 24 Feb 2003 19:35:04 -0800
From: Andrew Morton <akpm@digeo.com>
To: John Levon <levon@movementarian.org>
Cc: wli@holomorphy.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, gh@us.ibm.com
Subject: Re: Horrible L2 cache effects from kernel compile
Message-Id: <20030224193504.2ed65230.akpm@digeo.com>
In-Reply-To: <20030225031516.GC49589@compsoc.man.ac.uk>
References: <3E5ABBC1.8050203@us.ibm.com>
	<20030225005922.GU10411@holomorphy.com>
	<20030225031516.GC49589@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 03:34:43.0529 (UTC) FILETIME=[D6120390:01C2DC7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> wrote:
>
> On Mon, Feb 24, 2003 at 04:59:22PM -0800, William Lee Irwin III wrote:
> 
> > Your profile was upside down. I've re-sorted it.
> > It probably confused people who were wondering why the numbers
> > at the top of the profile were lower than the ones below them.
> 
> Would people generally prefer things to be sorted so the most important
> stuff was at the top ? We're considering such a change ...
> 

I prefer it the way it is, so unimportant stuff can scroll away.

Bill can just turn his monitor upside down.

