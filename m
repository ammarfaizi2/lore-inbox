Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTDPQda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTDPQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:33:29 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41367 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264482AbTDPQdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:33:07 -0400
Date: Wed, 16 Apr 2003 18:44:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Larson <plars@linuxtestproject.org>
Cc: ltp-coverage@lists.sourceforge.net,
       lse-tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ltp-coverage] 2.5.67-gcov and 2.4.20-gcov
Message-ID: <20030416164440.GB2305@wohnheim.fh-wedel.de>
References: <1050502803.8637.1094.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1050502803.8637.1094.camel@plars>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 April 2003 09:20:02 -0500, Paul Larson wrote:
> 
> The Linux Kernel GCOV patch has a new home.  It will now be available
> from the Linux Test Project site at: http://ltp.sourceforge.net.
> 
> This release updates the gcov-kernel patches and utilities for 2.5.67
> and 2.4.20 kernels, and includes some minor bugfixes.
> 
> The Linux Kernel GCOV patch allows utilization of the gcov tool
> against a running kernel.  This is different from most other profiling
> methods because it can easily tell you things like: which lines of code
> are executed, how many times they are executed, and how often different
> branches are taken.

Excuse me for being lazy. Does this already cover ppc? I submitted a
patch over some other channels some time ago.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
