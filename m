Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCMQbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCMQbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 11:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCMQbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 11:31:42 -0500
Received: from orb.pobox.com ([207.8.226.5]:34229 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261349AbVCMQbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 11:31:41 -0500
Date: Sun, 13 Mar 2005 08:31:38 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3
Message-ID: <20050313163138.GH9796@ip68-4-98-123.oc.oc.cox.net>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
> - A new version of the "acpi poweroff fix".  People who were having trouble
>   with ACPI poweroff, please test and report.

I've tested this set of ACPI poweroff patches with both clean, proper
shutdowns and Alt-SysRq-O, on hardware that previously didn't work. Now it
works.

-Barry K. Nathan <barryn@pobox.com>
