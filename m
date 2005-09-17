Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVIQVRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVIQVRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 17:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVIQVRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 17:17:00 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:34479 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1751202AbVIQVQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 17:16:59 -0400
Date: Sat, 17 Sep 2005 23:16:57 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Soeren Sandmann <sandmann@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce:  Sysprof 1.0 -- a sampling, systemwide Linux profiler
Message-ID: <20050917211656.GA27448@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Soeren Sandmann <sandmann@daimi.au.dk>, linux-kernel@vger.kernel.org
References: <ye8br2r9zi7.fsf@horse06.daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ye8br2r9zi7.fsf@horse06.daimi.au.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 11:05:04PM +0200, Soeren Sandmann wrote:
> * What is it?
> --------------------------
> 
> Sysprof is a sampling system-wide CPU profiler for Linux.
> 
> Sysprof uses a Linux kernel module to profile the entire system, not
> just an individual application. 

How is this different from oprofile? 

Looks like you did an exact, but less capable, reimplementation.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
