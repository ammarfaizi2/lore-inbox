Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbUAGRtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUAGRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:49:51 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:65016 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266260AbUAGRtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:49:46 -0500
Date: Wed, 7 Jan 2004 09:49:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040107174939.GK1882@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 01:46:30AM +0100, Guennadi Liakhovetski wrote:
> It is not just a problem of 2.6 with those specific network configurations
> - ftp / http / tftp transfers work fine. E.g. wget of the same file on the
> PXA with 2.6.0 from the PC1 with 2.4.21 over http takes about 2s. So, it
> is 2.6 + NFS.
> 
> Is it fixed somewhere (2.6.1-rcx?), or what should I try / what further
> information is required?

You will probably need to look at some tcpdump output to debug the problem...
