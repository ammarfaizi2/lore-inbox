Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271903AbTHEVIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271924AbTHEVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:08:55 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:19631 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S271903AbTHEVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:08:41 -0400
Date: Tue, 5 Aug 2003 23:08:38 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jim Penny <jpenny@universal-fasteners.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipsec and tunnel mode on kernel 2.6.0-test2
Message-ID: <20030805210838.GA12919@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jim Penny <jpenny@universal-fasteners.com>,
	linux-kernel@vger.kernel.org
References: <20030805152101.12d4bfd3.jpenny@universal-fasteners.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805152101.12d4bfd3.jpenny@universal-fasteners.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 03:21:01PM -0400, Jim Penny wrote:
> Is it working?
> 
> Suppose I am trying to connect 172.18.243.0/24 to 172.18.254.0/24 via
> 172.18.253.253 and 172.18.254.254. 
> 

Without looking at it further, have you compiled setkey & friends against a
recent kernel? There has been an ABI change recently.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
