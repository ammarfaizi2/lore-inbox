Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWBFEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWBFEfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWBFEfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:35:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18412 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750969AbWBFEfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:35:02 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pavel Machek <pavel@ucw.cz>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
In-Reply-To: <200602061402.54486.nigel@suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz>
	 <200602061402.54486.nigel@suspend2.net>
Content-Type: text/plain
Date: Sun, 05 Feb 2006 23:34:58 -0500
Message-Id: <1139200499.2791.210.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 14:02 +1000, Nigel Cunningham wrote:
> (they now have to download extra 
> libraries to use the splashscreen, which were not required with the 
> bootsplash patch, and need to check whether an update to the userui
> code 
> is required when updating the kernel) 

You could have avoided this problem by keeping the userspace<->kernel
interface stable.

Lee

