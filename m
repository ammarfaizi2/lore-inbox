Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbUCPRWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUCPRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:22:37 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:59465 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264215AbUCPRV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:21:29 -0500
Date: Tue, 16 Mar 2004 09:20:49 -0800
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040316172049.GA29568@sgi.com>
Mail-Followup-To: Jeremy Higdon <jeremy@sgi.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de
References: <20040316052256.GA647970@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316052256.GA647970@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 09:22:56PM -0800, Jeremy Higdon wrote:
> Prior to the last per-cpu patch, I was getting about 75000 to 80000
> IOPS at 100% cpu usage.
> 
> With the per-cpu patch, that went up to 110000 IOPS at 100% CPU.
> 
> With this patch, I'm seeing 200000 IOPS at about 65% CPU usage.

Well, that settles it, I'm going to have to start using your machine
instead. :)

Jesse
