Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTCHVIX>; Sat, 8 Mar 2003 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCHVIX>; Sat, 8 Mar 2003 16:08:23 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:48271 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S262208AbTCHVIX>; Sat, 8 Mar 2003 16:08:23 -0500
Date: Sat, 8 Mar 2003 13:18:59 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kelleycook@wideopenwest.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IBM^H^H^HHitachi disk tools (was Re: Disabling ATAPI retry?)
Message-ID: <20030308211859.GA32725@ip68-101-124-193.oc.oc.cox.net>
References: <3e67c49b.7c12.1804289383@wideopenwest.com> <1046991672.17715.134.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046991672.17715.134.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 11:01:12PM +0000, Alan Cox wrote:
> There isn't. You can always build a kernel set not to, but even then it
> takes the drive firmware a sizeable time to retry a block. If its an IBM
> you might want to try the ibm tools on them if you can get them. They 
> seem to have vanished from the face of the earth when IBM dumped its disk
> business 

Actually, IBM dumped its disk business to Hitachi, and that's where the
tools went too:
http://www.hgst.com/hdd/support/download.htm

They say "HITACHI" instead of "IBM" but otherwise they're the same tools
with the same user interface and same functionality.

-Barry K. Nathan <barryn@pobox.com>
