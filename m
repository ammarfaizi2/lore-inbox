Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUGUROl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUGUROl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266552AbUGUROl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:14:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45473 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266548AbUGUROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:14:40 -0400
Subject: Re: 2.6.8-rc2: 'Invalid MAC address' error with via-rhine driver
From: Lee Revell <rlrevell@joe-job.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721112803.GB9537@k3.hellgate.ch>
References: <1090369207.841.1.camel@mindpipe>
	 <20040721112803.GB9537@k3.hellgate.ch>
Content-Type: text/plain
Message-Id: <1090430081.901.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 13:14:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 07:28, Roger Luethi wrote:
> On Tue, 20 Jul 2004 20:20:17 -0400, Lee Revell wrote:
> > I get the following error trying to load the via-rhine module with
> > kernel 2.6.8-rc2.  I did not get this error with 2.6.8-rc1-mm1.
> > 
> > Jul 20 20:11:13 mindpipe kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
> > Jul 20 20:11:13 mindpipe kernel: Invalid MAC address for card #0
> > Jul 20 20:11:13 mindpipe kernel: via-rhine: probe of 0000:00:12.0 failed with error -5
> 
> The problem is known (see my other postings), but the cause is not. I
> cannot reproduce the problem, if you are willing to conduct a binary
> search with no more than 4 steps, I'll send you the relevant patches.
> 

Yes, send them to me, I should be able to nail this down.  Probably
won't have time for a day or two.

Lee

