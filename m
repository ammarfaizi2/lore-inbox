Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVCWCeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVCWCeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVCWCeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:34:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3818 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262719AbVCWC3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:29:33 -0500
Message-ID: <4240D47C.8090707@pobox.com>
Date: Tue, 22 Mar 2005 21:29:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Note on wireless development process
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a general note...  like many other areas of the kernel, there is no 
wireless roadmap.  There is a set of technical criteria (see '2.6.x 
wireless update and status' post), but there is no One True Path to 
follow to get there.

People interested in working on wireless need to be their own guides, 
and find their own path.  There has been endless discussion on wireless, 
and not much movement.  So asking questions without attaching a patch 
won't get very far.  The general process is just like any other kernel 
development process:  post a patch, get feedback, revise patch, lather 
rinse repeat.

Don't wait for DaveM or me to suddenly post reams of wireless code.  I'm 
speculating about David's time, but I'm just too darned busy.  David and 
I play the roles of reviewer and advisor.  It's up to YOU to "scratch 
the itch" and get world-class wireless support into Linux.

With regards to development process, the main point of coordination is 
the wireless-2.6 queue itself, not a human.  Look at the wireless-2.6 
tree, consider what your next step is, and go there.  Don't bother 
thinking too much about code outside that tree (and upstream).

Please direct questions and comments to the netdev@oss.sgi.com mailing 
list, rather than privately emailing me or DaveM.  That way knowledge is 
shared, debated, and archived.

	Jeff



