Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263694AbUCYWjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUCYWg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:36:26 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:58124 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263694AbUCYWfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:35:45 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
Date: Thu, 25 Mar 2004 23:35:10 +0100
User-Agent: KMail/1.6.1
Cc: Rik van Ballegooijen <sleightofmind@xs4all.nl>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, len.brown@intel.com
References: <200403251432.32787@WOLK> <20040325090232.15e8f59f.akpm@osdl.org> <40633843.3090300@xs4all.nl>
In-Reply-To: <40633843.3090300@xs4all.nl>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403252335.10841@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 March 2004 20:51, Rik van Ballegooijen wrote:

> | It would be interesting to try reverting probe_roms-02-fixes.patch and
> | probe_roms-01-move-stuff.patch.

> Reverting these two patches does nothing. The result is exactly the same
> as above.
> Reverting the acpi stuff that went into -bk some days ago does solve the
> problem. I haven't checked yet which part to be exact causes this though.

same here.

ciao, Marc
