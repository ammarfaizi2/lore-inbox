Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUGVOnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUGVOnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUGVOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 10:43:19 -0400
Received: from hera.kernel.org ([63.209.29.2]:3212 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265966AbUGVOnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 10:43:17 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: linux-kernel CVS gateway?
Date: Thu, 22 Jul 2004 14:41:52 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cdojng$it7$1@terminus.zytor.com>
References: <20040717213703.GE5464@admingilde.org> <1090142336.15165.1.camel@localhost> <20040718201014.GA8291@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1090507312 19368 127.0.0.1 (22 Jul 2004 14:41:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 22 Jul 2004 14:41:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040718201014.GA8291@admingilde.org>
By author:    Martin Waitz <tali@admingilde.org>
In newsgroup: linux.dev.kernel
> 
> hi :)
> 
> On Sun, Jul 18, 2004 at 11:18:56AM +0200, Kasper Sandberg wrote:
> > they are using bitkeeper
> 
> sure, but Larry announced the CVS gateway some months ago...
> now that I wanted to give it a try, it doesn't exist anymore :(
> 

Just rsync the CVS repository from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/bkcvs/

The direct access to the repository was removed due to disuse and
security problems.  The rsync is a lot nicer anyway.

	-hpa
