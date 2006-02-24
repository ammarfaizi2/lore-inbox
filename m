Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWBXIb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWBXIb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBXIb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:31:27 -0500
Received: from ns1.siteground.net ([207.218.208.2]:43929 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932093AbWBXIb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:31:26 -0500
Date: Fri, 24 Feb 2006 00:31:55 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu pages.
Message-ID: <20060224083155.GA3602@localhost.localdomain>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com> <20060223113331.6b345e1b.akpm@osdl.org> <Pine.LNX.4.64.0602231140140.13899@schroedinger.engr.sgi.com> <20060224012815.GB5589@localhost.localdomain> <Pine.LNX.4.64.0602231823340.18354@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602231823340.18354@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 06:25:37PM -0800, Christoph Lameter wrote:
> On Thu, 23 Feb 2006, Ravikiran G Thirumalai wrote:
> 
> Could you show us the patch?

Sure.  They are in a series on our tree here and I am removing dependencies
and rediffing against current -mm.  Should post them tomorrow.

