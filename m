Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWA1UJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWA1UJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 15:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWA1UJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 15:09:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750730AbWA1UJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 15:09:55 -0500
Date: Sat, 28 Jan 2006 12:09:46 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: steiner@sgi.com, linux-kernel@vger.kernel.org, rml@novell.com,
       akpm@osdl.org
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-Id: <20060128120946.648bcf6a.pj@sgi.com>
In-Reply-To: <20060128133244.GA22704@elte.hu>
References: <20060127230659.GA4752@sgi.com>
	<20060127191400.aacb8539.pj@sgi.com>
	<20060128133244.GA22704@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> i'm to blame for the syscall, Robert is to blame for the tool side

And here I've been blaming Robert for that syscall all these years.

My humble apologies, Robert ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
