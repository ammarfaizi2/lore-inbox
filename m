Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTAOWiO>; Wed, 15 Jan 2003 17:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbTAOWiO>; Wed, 15 Jan 2003 17:38:14 -0500
Received: from smtp14.us.dell.com ([143.166.85.137]:45447 "EHLO
	smtp14.us.dell.com") by vger.kernel.org with ESMTP
	id <S267368AbTAOWiN>; Wed, 15 Jan 2003 17:38:13 -0500
Date: Wed, 15 Jan 2003 16:46:57 -0600 (CST)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: robert@ping.us.dell.com
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
In-Reply-To: <20030115143313.76953b63.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301151645220.23245-100000@ping.us.dell.com>
X-Complaints-to: /dev/null
X-Apparently-From: mars
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Andrew Morton wrote:
> Suggest that you make sure it's not some strangeness in the kernel build
> system which is writing out a modified .config file.

Will apply patch, but for the .config issue, the config file is correct 
after the build, then I reboot, and it goes back to its original state.



