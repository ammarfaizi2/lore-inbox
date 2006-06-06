Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWFFWks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWFFWks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFFWks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:40:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751265AbWFFWkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:40:47 -0400
Date: Tue, 6 Jun 2006 15:40:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: balbir@in.ibm.com, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       peterc@gelato.unsw.edu.au
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge
 plans)
Message-Id: <20060606154034.10147da7.akpm@osdl.org>
In-Reply-To: <4486017F.8030308@watson.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<4484D25E.4020805@in.ibm.com>
	<4486017F.8030308@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 18:28:15 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> So, we have a good consensus from existing/potential users of taskstats and would
> very much appreciate it being included in 2.6.18.

Yes, for 2.6.18 I'm inclined to send taskstats and to continue to play
wait-and-see on the statistics infrastructure.  Greg is taking a look at
the stats code, which is good.

