Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTLCRov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTLCRov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:44:51 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:64967 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263996AbTLCRou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:44:50 -0500
Date: Wed, 3 Dec 2003 09:44:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
Message-ID: <20031203174445.GA29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Ian Soboroff <ian.soboroff@nist.gov>,
	linux-kernel@vger.kernel.org
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 09:51:36AM -0500, Ian Soboroff wrote:
> 
> I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
> kernel with Andrea's patches on it, otherwise it dies from lack of
> lowmem.  
> 
> The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
> Changelog that at least some bits of Andrea's VM were merged.  Should
> I be able to run a vanilla 2.4.23 on this box?
> 

A good amount of the VM was merged into 2.4.23-pre3, so the -aa patches against
pre6 should show you what is missing.

That said, I have seen a report that no stock 2.4 kernel would run well >
4GB memory until 2.4.23, but he didn't say how much memory he had.

