Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275000AbTHQCSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275002AbTHQCSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:18:15 -0400
Received: from holomorphy.com ([66.224.33.161]:22240 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275000AbTHQCSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:18:07 -0400
Date: Sat, 16 Aug 2003 19:19:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030817021916.GO32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <20030814070119.GN32488@holomorphy.com> <3F3BEA65.8080907@techsource.com> <200308160238.05185.kernel@kolivas.org> <3F3D2290.6070804@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3D2290.6070804@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:12:32PM -0400, Timothy Miller wrote:
> Ok, I'm just a little confused, because of this inversion of "high 
> priority" with "low numbers".
> First, am I correct in understanding that a lower number means a higher 
> priority?
> And for a higher priority, in addition to begin run before all tasks of 
> lower priority, they also get a longer timeslice?

Yes on both counts.


-- wli
