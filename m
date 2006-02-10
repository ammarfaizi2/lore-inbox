Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWBJHUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWBJHUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBJHUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:20:07 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:12269 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1751171AbWBJHUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:20:05 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Fri, 10 Feb 2006 07:20:03 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <20060210064612.GE12046@ca-server1.us.oracle.com>
In-Reply-To: <20060210064612.GE12046@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100720.04005.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 10 February 2006 06:46, Mark Fasheh wrote:
>
> Great. We'll keep things simple at first. If I could get a copy of the
> /etc/ocfs2/cluster.conf files from each node that'd be great. A full log of
> the OCFS2 messages you see on each node, starting from mount to unmount
> would also help. That includes any dlm_* messages - in particular the ones
> printed when a node mounts and unmounts. If you're using any mount options
> it'd be helpful to know those too.


 Hi Mark

 Thanks for the quick reply. I'll redo the steps from scratch, capture the 
messages since the first mount and send that info ASAP.

 Thanks for the help

Regards

Claudio

