Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUCQUUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCQUUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:20:51 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:7841 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262045AbUCQUUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:20:50 -0500
Message-ID: <4058B317.90101@stesmi.com>
Date: Wed, 17 Mar 2004 21:20:39 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: billy rose <billyrose@cox-internet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc error?
References: <4058A57B.4040006@cox-internet.com>
In-Reply-To: <4058A57B.4040006@cox-internet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

billy rose wrote:

> is the 40+ parameter sprintf() in proc_pid_stat() flushing out a bug in 
> gcc on this? ive tried setting the cpu type to 386, 486, and 586 but 
> still get the same error.
> 
> gcc -v shows 2.96.20000731
> redhat 7.3
> running kernel 2.4.18-3 or 2.4.20
> kernel being compiled is 2.6.4

Stop right here.

Update to the latest 2.96 compiler or go to 3.x before proceeding.

I believe that one you have there has more bugs than a windows system.

Well.. Almost. The newer ones were good however but the early ones
weren't.

I'd recommend you install 3.2.x and try again but if you don't then
grab latest errata update to 2.96 and use that. Then if it still
doesn't work you can always ask here again.

// Stefan
