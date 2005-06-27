Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVF0SOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVF0SOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVF0SOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:14:46 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:39836 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261536AbVF0SOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:14:44 -0400
Date: Mon, 27 Jun 2005 20:14:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Clyde Griffin <CGRIFFIN@novell.com>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Message-ID: <20050627181428.GA1415@elf.ucw.cz>
References: <s2bae938.075@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2bae938.075@sinclair.provo.novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(please wrap your lines after 72 characters or so)

> Novell engineering is introducing the Novell Linux Kernel Debugger (NLKD) as an open source project intended to provide an enhanced and robust debugging experience for Linux kernel developers. 
> 
> The project (nlkd) at http://forge.novell.com/modules/xfmod/project/?nlkd currently has code patches to SUSE Linux Enterprise Server v9 SP1 and SP2, which when applied allow kernel developers to recompile the Linux kernel exposing the functionality provided by NLKD.  
> 
> Patches against the mainline will be forthcoming after community
> feedback.

gettingRidOfFunkyCapitalisation and rid of hungarian notation_t would
be a good start. (I only seen the docs, but it has some code snippets
that look very ugly).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
