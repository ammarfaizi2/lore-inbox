Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUHDUqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUHDUqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUHDUqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:46:47 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:22697 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267414AbUHDUqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:46:45 -0400
Date: Wed, 4 Aug 2004 13:43:29 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: ak@suse.de, maneesh@in.ibm.com, shemminger@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Improve readability by hiding read_barrier_depends() calls
Message-ID: <20040804204329.GD1239@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040804142845.GB1865@us.ibm.com> <20040805192756.GE3935@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805192756.GE3935@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:57:56AM +0530, Dipankar Sarma wrote:
> It will be easier to stick the two patches from Paul on top of these,
> so I will merge these with my patchset and send the entire set
> of 5 patches for -mm testing.

Works for me!  ;-)

						Thanx, Paul
