Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTD0JO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTD0JO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 05:14:26 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:25606 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263863AbTD0JOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 05:14:25 -0400
Date: Sun, 27 Apr 2003 19:26:27 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Junfeng Yang <yjf@stanford.edu>
cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 30 potential dereference of user-pointer errors
In-Reply-To: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
Message-ID: <Mutt.LNX.4.44.0304271925350.870-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Junfeng Yang wrote:

> Where bugs occur:
> 
> net/ipv4/ip_sockglue.c

Which kernel version is this for?


- James
-- 
James Morris
<jmorris@intercode.com.au>

