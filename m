Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUBRHZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUBRHZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:25:23 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:40588 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263606AbUBRHZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:25:19 -0500
Date: Wed, 18 Feb 2004 08:25:13 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218072513.GA10446@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl> <c0ukd2$3uk$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ukd2$3uk$1@terminus.zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:58:42AM +0000, H. Peter Anvin wrote:

> Indeed.  The original name for the encoding was, in fact, "FSS-UTF",
> for "filesystem safe Unicode transformation format."  

That might explain a few things.

> > F8 80 80 80 AE F8 80 80 80 AE 
> > FC 80 80 80 80 AE FC 80 80 80 80 AE
> 
> No, they don't.

Serves me right for trusting a random site, apologies. 

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
