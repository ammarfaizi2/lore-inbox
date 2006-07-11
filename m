Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWGKGWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWGKGWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWGKGWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:22:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44013 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965219AbWGKGWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:22:02 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Agenda for NUMA BOF @OLS & NUMA paper
Date: Tue, 11 Jul 2006 08:22:52 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Marcelo Tosatti <marcelo@kvack.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>, dgc@sgi.com,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Lee Schermerhorn <Lee.Schermerhorn@hp.com>, jes@sgi.com,
       Adam Litke <agl@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       steiner@sgi.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, akpm@osdl.org
References: <Pine.LNX.4.64.0607101146170.5556@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607101146170.5556@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607110822.53711.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 21:22, Christoph Lameter wrote:

> Here is a one liner for each subject that may be useful to discuss. I'd be
> interested in hearing if there are any other issues that would need our
> attention or maybe some of these are not that important (Probably too many
> subjects already ...). Maybe this thread will allow those who will not be
> at the OLS to give us some imput.

Sounds reasonable, although it would be a lot of things to discuss.
Ok most of A doesn't seem to be directly NUMA related.
Does B mean you want to work on that?  My impression was always
that doing it automatically in the kernel was more a deadend.

-Andi
