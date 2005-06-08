Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFHQKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFHQKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFHQJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:09:27 -0400
Received: from c64.shuttle.de ([194.95.226.64]:49539 "EHLO c64.shuttle.de")
	by vger.kernel.org with ESMTP id S261345AbVFHQCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:02:36 -0400
X-Virus-Check: ClamAV 0.85.1/921 on c64.shuttle.de; Wed, 08 Jun 2005 18:02:35 +0200
Date: Wed, 8 Jun 2005 18:02:35 +0200
From: Frank Elsner <frank@moltke28.B.Shuttle.DE>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11:   kernel BUG at fs/jbd/checkpoint.c:247!
In-Reply-To: <20050608153615.GA27540@atrey.karlin.mff.cuni.cz>
References: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
	<20050608153615.GA27540@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1Dg30l-0003PL-62@moltke28.B.Shuttle.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005 17:36:15 +0200 Jan Kara <jack@suse.cz> wrote:
> > I'm not a kernel hacker. Maybe some of you knows what happened :-)
>   Looks like a bug in the kernel :). Can you please try 2.6.12-rc5 or
> newer? It should contain several fixes in this area.

I'm currently running 2.6.12-rc5 as suggested by Andrew Morton
                                 on Sat, 4 Jun 2005 03:07:40 -0700.

Thanks for dealing with the problem.


--Frank Elsner
