Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUHJHwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUHJHwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 03:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUHJHwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 03:52:41 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:1725 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261252AbUHJHwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 03:52:40 -0400
Date: Tue, 10 Aug 2004 09:52:39 +0200
From: bert hubert <ahu@ds9a.nl>
To: Robert Crawford <flacycads@access4less.net>
Cc: linux-kernel@vger.kernel.org
Subject: [cdrecord ('Cannot allocate memory') breakage] Re: 2.6.8-rc3-mm1 & mm2 break k3b
Message-ID: <20040810075239.GA23087@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Robert Crawford <flacycads@access4less.net>,
	linux-kernel@vger.kernel.org
References: <200408100011.30730.flacycads@access4less.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408100011.30730.flacycads@access4less.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:11:30AM +0000, Robert Crawford wrote:


> Unable to determine the last tracks data mode. using default
> cdrecord returned an unknown error (code 12)
> Cannot allocate memory

This error has also been reported by:
Alexander Gran      ( 0.5K) Re: Cannot burn without strace on 2.6.8-rc3-mm1

In his case it goes away when stracing the process.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
