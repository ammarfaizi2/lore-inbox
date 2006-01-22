Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWAVR6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWAVR6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAVR6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:58:49 -0500
Received: from xenotime.net ([66.160.160.81]:43657 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751300AbWAVR6s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:58:48 -0500
Date: Sun, 22 Jan 2006 09:58:56 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Daniel =?ISO-8859-1?B?QXJhZ29u6XM=?= <danarag@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem: Bug in my patch
Message-Id: <20060122095856.32b065e8.rdunlap@xenotime.net>
In-Reply-To: <43D3C616.8070007@gmail.com>
References: <43D3C616.8070007@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006 18:51:18 +0100 Daniel Aragonés wrote:

> In my former posting in the list
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113766834512624&w=2
> 
> an important bug has to be corrected, otherwise the number of files is
> limited to 65.536 and file corruption can occur.
> 
> See the solution in my last post to comp.os.minix:
> 
> http://groups.google.com/group/comp.os.minix/browse_thread/thread/2bbdeadd8eab0bd0/49077d297f205c69#49077d297f205c69
> 
> I am sorry for the inconvenience.

so please post the patch either to linux-kernel or
linux-fsdevel@vger.kernel.org.

thanks,
---
~Randy
