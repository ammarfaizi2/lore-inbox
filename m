Return-Path: <linux-kernel-owner+w=401wt.eu-S1751439AbXAFSBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbXAFSBK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXAFSBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:01:10 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:38316 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXAFSBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:01:09 -0500
Date: Sat, 6 Jan 2007 10:00:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel-doc:  what is the purpose of "&struct"?
Message-Id: <20070106100019.98da5537.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0701060941240.13398@localhost.localdomain>
References: <Pine.LNX.4.64.0701060941240.13398@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 09:44:39 -0500 (EST) Robert P. J. Day wrote:

> 
>   according to the kernel-doc HOWTO, the following should be
> "highlighted" in some way if found in the extractable documentation of
> your source file:
> 
>   '&struct_name' - name of a structure (up to two words including 'struct')
> 
> but examples of that, at least in the HTML, are simply printed in
> regular font prefixed with '&' -- i don't see that any "highlighting"
> is being done.

The struct name is highlighted in 'man' output mode.
Not done in text or html output modes.

>   the intermediate XML contains simply "&amp;struct", which certainly
> doesn't suggest any special processing or highlighting.
> 
>   am i missing something?

---
~Randy
