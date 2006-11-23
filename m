Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933394AbWKWTmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933394AbWKWTmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933400AbWKWTmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:42:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:15307
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933271AbWKWTmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:42:42 -0500
Date: Thu, 23 Nov 2006 11:42:47 -0800 (PST)
Message-Id: <20061123.114247.129061695.davem@davemloft.net>
To: dgc@sgi.com
Cc: jesper.juhl@gmail.com, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to
 implicate xfs, scsi, networking, SMP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061123070837.GV11034@melbourne.sgi.com>
References: <20061123011809.GY37654165@melbourne.sgi.com>
	<20061122.201013.112290046.davem@davemloft.net>
	<20061123070837.GV11034@melbourne.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chinner <dgc@sgi.com>
Date: Thu, 23 Nov 2006 18:08:37 +1100

> Sure, we're trying to but it takes time.  However, if it's such a
> problem for you now and you want this process sped up, then _please,
> please, please_ submit patches to help fix the problem.....

As noted in other replies, such patch submissions have been rejected
by the XFS maintainers in the past.  So don't give the false
impression that people aren't trying to submit patches to fix this
problem.

The problem is the XFS maintainers rejecting the layering removal
patches.

