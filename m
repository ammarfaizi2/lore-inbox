Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTJ0AHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTJ0AHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:07:11 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:21264 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263697AbTJ0AHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:07:09 -0500
Date: Sun, 26 Oct 2003 16:07:04 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
Message-ID: <20031027000704.GB5198@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3F9BC429.6060608@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9BC429.6060608@planet.nl>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 01:55:05PM +0100, Stef van der Made wrote:
> 
> On my AMD athlon system with 512MB memory I sometimes get a lot of disk 
> activity the activity normaly lasts for about 10 seconds and after that 
> the disk stays relativily quiet as expected with the load on the system. 
> When I look into top I don't see any programs that could explain the 
> disk activity. The system is in most cases not using any swap.

In the vein of "make sure its plugged in", make sure it
isn't cron.
