Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268207AbTALCuz>; Sat, 11 Jan 2003 21:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268208AbTALCuz>; Sat, 11 Jan 2003 21:50:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1688 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268207AbTALCuz>; Sat, 11 Jan 2003 21:50:55 -0500
Date: Sat, 11 Jan 2003 21:59:41 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301120259.h0C2xft07933@devserv.devel.redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
In-Reply-To: <mailman.1042256580.21471.linux-kernel2news@redhat.com>
References: <mailman.1042256580.21471.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> Oliver Xymoron (and others?) mentioned that one could do iSCSI in
> userspace.  Well, Intel has code at
> 	http://sourceforge.net/projects/intel-iscsi
> 
> Just looking at the todo and glancing at the code shows that it is far
> from optimal, but at the same time it is open source and a working
> starting point for anyone interested in optimizing it.
> 
> 	Jeff

I thought the canonical target was "UNH", and canonical
initiator was Cisco, the issue long settled... Intel is, well...
it's there to keep the leaders honest. Ask MKJ, he
actually tried that thing. He'll tell you what's real.

-- Pete
