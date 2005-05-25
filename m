Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEYXDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEYXDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVEYXDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:03:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44758 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261584AbVEYXDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:03:42 -0400
Message-ID: <4295044B.7090604@pobox.com>
Date: Wed, 25 May 2005 19:03:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches try2] 2.6.x net driver updates
References: <4294BD9C.2050105@pobox.com> <Pine.LNX.4.58.0505251200040.2307@ppc970.osdl.org> <42950334.9090402@pobox.com>
In-Reply-To: <42950334.9090402@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Not specialized at all.  I do one pull at a time, so git-pull-script 
> suffices with a simple addition to call git-resolve-script with the 
> branch as $4, and a simple addition to git-resolve-script to add 'branch 

Correction: new $4 arg was added to git-resolve-script, not git-pull-script
