Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCKT44>; Tue, 11 Mar 2003 14:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbTCKT44>; Tue, 11 Mar 2003 14:56:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:6792 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261584AbTCKT4z>;
	Tue, 11 Mar 2003 14:56:55 -0500
Date: Tue, 11 Mar 2003 12:08:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: phillips@arcor.de, zbrown@tumblerings.org, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-Id: <20030311120824.2f5a7374.akpm@digeo.com>
In-Reply-To: <24360000.1047411221@flay>
References: <200303020011.QAA13450@adam.yggdrasil.com>
	<20030311184043.GA24925@renegade>
	<22230000.1047408397@flay>
	<20030311192639.E72163C5BE@mx01.nexgo.de>
	<24360000.1047411221@flay>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2003 20:07:31.0132 (UTC) FILETIME=[D8E967C0:01C2E809]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >> At the moment, I slap the patches back on top of every new version
> >> seperately, which works well, but is a PITA.
> > 
> > Tell me about it.
> 
> Well, it normally only takes me an hour per release.

Whoa.  You need better tools.

A bunch of fine people took patch-tools and turned them into a real project. 
They have .deb's and .rpm's, but it looks like they're a bit old and a `cvs co'
is needed.  I'm still using the old stuff, but I'm sure theirs is better.

See http://savannah.nongnu.org/projects/quilt/


