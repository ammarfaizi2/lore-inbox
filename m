Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTEMWwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTEMWwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:52:12 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:60396 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S263642AbTEMWwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:52:10 -0400
Date: Tue, 13 May 2003 16:04:32 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4 fails to boot
Message-ID: <20030513230432.GM32128@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030513221435.GI32128@ca-server1.us.oracle.com> <20030513152713.217aac7a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513152713.217aac7a.akpm@digeo.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 03:27:13PM -0700, Andrew Morton wrote:
> Try using a different IO scheduler?

	Ok, elevator=deadline doesn't fix it, nor does removing the
serial console from the command line.

Joel

-- 

"Conservative, n.  A statesman who is enamoured of existing evils,
 as distinguished from the Liberal, who wishes to replace them
 with others."
	- Ambrose Bierce, The Devil's Dictionary

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
