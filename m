Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUCOP2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 10:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCOP2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 10:28:03 -0500
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:12161 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S262600AbUCOP2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 10:28:01 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 15 Mar 2004 10:28:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040315152801.GA6604@ncsu.edu>
References: <40528383.10305@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40528383.10305@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:44:03PM -0600, Ray Bryant wrote:
> We've run into a scaling problem using hugetlbpages in very large memory 
> machines, e. g. machines with 1TB or more of main memory.

You know, when I started using Linux it wouldn't support more than 16M
of ram.  No one complained because no one using Linux had a machine with
more than 16M of ram.  It looks like things have progressed a bit since
then :-)

Jim
