Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUADLrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUADLrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:47:19 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:43457 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264291AbUADLrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:47:16 -0500
Date: Sun, 4 Jan 2004 03:47:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.6.1-rc1-mjb1
Message-ID: <20040104114710.GQ1882@matchmail.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <4690000.1073090546@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4690000.1073090546@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 04:42:26PM -0800, Martin J. Bligh wrote:
> Now in Linus' tree:
> - readahead_fixes				Ram Pai
> 	Fix performance bugs in readahead

Boo!  ;)

Hopefuly that'll be backed out of Linus' tree.  Since it has caused
regressions.  Has Ram Pai been notified of the hdparm -t regression?

There is an active thread about this on lkml right now.
