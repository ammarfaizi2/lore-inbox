Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbTE3Up2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTE3Up2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:45:28 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:65296
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264302AbTE3Up1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:45:27 -0400
Date: Fri, 30 May 2003 13:52:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Daniel Goller <dgoller@satx.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030530205223.GB25810@matchmail.com>
Mail-Followup-To: Daniel Goller <dgoller@satx.rr.com>,
	linux-kernel@vger.kernel.org
References: <1054321731.13265.8.camel@schlaefer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054321731.13265.8.camel@schlaefer>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 02:08:51PM -0500, Daniel Goller wrote:
> i tried 2.4.21-rc6 as i was told it might fix the mouse stalling on
> heavy disk IO problem and i would like to report that it DOES fix them
> for the most part, even certain compiles/benchmarks/stress tests that
> could stall my pc for seconds now affect the mouse for mere fractions of
> one second, situations that used to cause short stalls are now a thing
> of the past
> 
> 2.4.21-rc6 is the best kernel i have tried to date and i have tried many
> on my quest to get a smooth mouse

There are reports that 2.4.18 also "fixed" the problems with the mouse.  Can
you verify?
