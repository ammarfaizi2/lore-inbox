Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUJUQ21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUJUQ21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268802AbUJUQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:28:20 -0400
Received: from relay00.uchicago.edu ([128.135.12.75]:15755 "EHLO
	relay00.uchicago.edu") by vger.kernel.org with ESMTP
	id S268803AbUJUQZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:25:52 -0400
Date: Thu, 21 Oct 2004 11:25:50 -0500
From: Ryan Reich <ryanr@uchicago.edu>
To: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: OOPS on 2.6.9 while compiling, very reproducible
Message-ID: <20041021162550.GA2602@ryanr>
References: <20041021054844.GA3335@ryanr> <4177D68A.2070100@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177D68A.2070100@namesys.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, resending this to the _entire_ list, not just Hans.

<snip OOPS>

On Thu, Oct 21, 2004 at 08:32:26AM -0700, Hans Reiser wrote:

> Are you using a compiler version that is accepted for use by the kernel? 
> Which version?

Was using 3.4.1, but I recompiled:

[ryanr: ~]$ cat /proc/version
Linux version 2.6.9 (ryanr@ryanr) (gcc version 2.95.3 20010315 (release)) #1
Thu Oct 21 11:15:06 CDT 2004

Same OOPS.

-- 
Ryan Reich
ryanr@uchicago.edu
